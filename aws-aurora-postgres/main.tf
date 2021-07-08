locals {
  # For Aurora postgres, the parameter group names before Postgres version 10
  # are named like "aurora-postgresql9.6", but for version 10 and above the
  # name omits the minor version e.g. "aurora-postgresql10". We parse the
  # engine version to distinguish the 2 cases.
  split_engine_version  = split(".", var.engine_version)
  params_engine_version = local.split_engine_version[0] == "9" ? join(".", slice(local.split_engine_version, 0, 2)) : local.split_engine_version[0]
}

module "aurora" {
  source                = "../aws-aurora"
  engine                = "aurora-postgresql"
  engine_version        = var.engine_version
  params_engine_version = local.params_engine_version

  project = var.project
  env     = var.env
  service = var.service
  owner   = var.owner

  database_name                       = var.database_name
  database_subnet_group               = var.database_subnet_group
  database_password                   = var.database_password
  database_username                   = var.database_username
  db_parameters                       = var.db_parameters
  rds_cluster_parameters              = var.rds_cluster_parameters
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  performance_insights_enabled        = var.performance_insights_enabled
  enabled_cloudwatch_logs_exports     = ["postgresql"]
  ca_cert_identifier                  = var.ca_cert_identifier
  auto_minor_version_upgrade          = var.auto_minor_version_upgrade

  ingress_cidr_blocks     = var.ingress_cidr_blocks
  ingress_security_groups = var.ingress_security_groups
  vpc_id                  = var.vpc_id
  publicly_accessible     = var.publicly_accessible
  port                    = 5432
  instance_class          = var.instance_class
  instance_count          = var.instance_count

  # backtrack_window not supported yet
  backtrack_window    = 0
  snapshot_identifier = var.snapshot_identifier
  skip_final_snapshot = var.skip_final_snapshot
  kms_key_id          = var.kms_key_id
  apply_immediately   = var.apply_immediately
}
