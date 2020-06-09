locals {
  name = "${var.project}-${var.env}-${var.service}"

  tags = {
    managedBy = "terraform"
    Name      = local.name
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
  }
}

resource "aws_security_group" "rds" {
  name        = local.name
  description = "Allow db traffic."

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_cidr_blocks
    content {
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  dynamic "ingress" {
    for_each = var.ingress_security_groups
    content {
      from_port       = var.port
      to_port         = var.port
      protocol        = "tcp"
      security_groups = [ingress.value]
    }
  }


  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name, description]
  }

  tags = local.tags
}

resource "aws_rds_cluster" "db" {
  engine         = var.engine
  engine_version = var.engine_version

  cluster_identifier                  = local.name
  database_name                       = var.database_name
  master_username                     = var.database_username
  master_password                     = var.database_password
  vpc_security_group_ids              = [aws_security_group.rds.id]
  db_subnet_group_name                = var.database_subnet_group
  storage_encrypted                   = true
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  backup_retention_period             = 28
  snapshot_identifier                 = var.snapshot_identifier
  final_snapshot_identifier           = "${local.name}-snapshot"
  skip_final_snapshot                 = var.skip_final_snapshot
  backtrack_window                    = var.backtrack_window
  kms_key_id                          = var.kms_key_id
  port                                = var.port
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.db.id
  deletion_protection                 = var.db_deletion_protection

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  apply_immediately = var.apply_immediately

  tags = local.tags
}

resource "aws_rds_cluster_instance" "db" {
  engine         = var.engine
  engine_version = var.engine_version

  count                      = var.instance_count
  identifier                 = "${local.name}-${count.index}"
  cluster_identifier         = aws_rds_cluster.db.id
  instance_class             = var.instance_class
  db_subnet_group_name       = var.database_subnet_group
  db_parameter_group_name    = aws_db_parameter_group.db.name
  ca_cert_identifier         = var.ca_cert_identifier
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  publicly_accessible          = var.publicly_accessible
  performance_insights_enabled = var.performance_insights_enabled

  apply_immediately = var.apply_immediately

  tags = local.tags
}

resource "aws_rds_cluster_parameter_group" "db" {
  name        = local.name
  family      = "${var.engine}${var.params_engine_version}"
  description = "RDS default cluster parameter group"

  dynamic "parameter" {
    for_each = var.rds_cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = local.tags
}

resource "aws_db_parameter_group" "db" {
  name   = local.name
  family = "${var.engine}${var.params_engine_version}"

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = local.tags
}
