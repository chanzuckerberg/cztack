locals {
  name = "${var.project}-${var.env}-${var.service}"

  tags = {
    managedBy = "terraform"
    Name      = "${var.project}-${var.env}-${var.service}"
    project   = "${var.project}"
    env       = "${var.env}"
    service   = "${var.service}"
    owner     = "${var.owner}"
  }
}

resource "aws_security_group" "rds" {
  name        = "${local.name}"
  description = "Allow postgres inbound"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = "${var.database_port}"
    to_port     = "${var.database_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.ingress_cidr_blocks}"]
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = ["name"]
  }

  tags = "${local.tags}"
}

resource "aws_rds_cluster" "db" {
  engine = "aurora-mysql"

  cluster_identifier                  = "${local.name}"
  database_name                       = "${var.database_name}"
  master_username                     = "${var.database_username}"
  master_password                     = "${var.database_password}"
  vpc_security_group_ids              = ["${aws_security_group.rds.id}"]
  db_subnet_group_name                = "${var.database_subnet_group}"
  storage_encrypted                   = true
  iam_database_authentication_enabled = true
  backup_retention_period             = 28
  final_snapshot_identifier           = "${local.name}-snapshot"
  skip_final_snapshot                 = "${var.skip_final_snapshot}"
  backtrack_window                    = "${var.backtrack_window}"

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  apply_immediately = "${var.apply_immediately}"

  tags = "${local.tags}"
}

resource "aws_rds_cluster_instance" "db" {
  engine = "aurora-postgresql"

  count                   = "${var.instance_count}"
  identifier              = "${local.name}-${count.index}"
  cluster_identifier      = "${aws_rds_cluster.db.id}"
  instance_class          = "${var.instance_class}"
  db_subnet_group_name    = "${var.database_subnet_group}"
  db_parameter_group_name = "${aws_db_parameter_group.db.name}"

  tags = "${local.tags}"
}

resource "aws_rds_cluster_parameter_group" "db" {
  name        = "${local.name}"
  family      = "aurora-postgresql9.6"
  description = "RDS default cluster parameter group"

  parameter = ["${var.rds_cluster_parameters}"]

  tags = "${local.tags}"
}

resource "aws_db_parameter_group" "db" {
  name   = "${local.name}"
  family = "aurora-postgresql9.6"

  parameter = ["${var.db_parameters}"]

  tags = "${local.tags}"
}
