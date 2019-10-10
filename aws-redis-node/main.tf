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

resource "aws_elasticache_subnet_group" "default" {
  name       = "${var.resource_name != "" ? var.resource_name : local.name}"
  subnet_ids = "${var.subnets}"
}

resource "aws_elasticache_cluster" "default" {
  cluster_id           = "${var.resource_name != "" ? var.resource_name : local.name}"
  engine               = "redis"
  engine_version       = "${var.engine_version}"
  node_type            = "${var.instance_type}"
  port                 = "${var.port}"
  num_cache_nodes      = 1
  parameter_group_name = "${var.parameter_group_name}"
  subnet_group_name    = "${aws_elasticache_subnet_group.default.name}"
  security_group_ids   = "${var.ingress_security_group_ids}"
  apply_immediately    = "${var.apply_immediately}"
  availability_zone    = "${var.availability_zone}"
  tags                 = "${local.tags}"
}
