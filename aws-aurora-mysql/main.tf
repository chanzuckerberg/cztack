module "aurora" {
  source         = "../aws-aurora"
  engine         = "aurora-mysql"
  engine_version = "5.7"

  project = "${var.project}"
  env     = "${var.env}"
  service = "${var.service}"
  owner   = "${var.owner}"

  database_name                       = "${var.database_name}"
  database_subnet_group               = "${var.database_subnet_group}"
  database_password                   = "${var.database_password}"
  database_username                   = "${var.database_username}"
  db_parameters                       = "${var.db_parameters}"
  rds_cluster_parameters              = "${var.rds_cluster_parameters}"
  iam_database_authentication_enabled = false
  performance_insights_enabled        = "${var.performance_insights_enabled}"
  enabled_cloudwatch_logs_exports     = ["audit", "error", "general", "slowquery"]

  ingress_cidr_blocks = "${var.ingress_cidr_blocks}"
  vpc_id              = "${var.vpc_id}"
  publicly_accessible = "${var.publicly_accessible}"
  port                = 3306

  instance_class = "${var.instance_class}"
  instance_count = "${var.instance_count}"

  backtrack_window    = "${var.backtrack_window}"
  skip_final_snapshot = "${var.skip_final_snapshot}"

  kms_key_id = "${var.kms_key_id}"

  apply_immediately = "${var.apply_immediately}"
}
