locals {
  name = "${var.tags.project}-${var.tags.env}-${var.tags.service}"
}

module "sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "5.1.2"
  name        = var.resource_name != "" ? var.resource_name : local.name
  description = "Allow traffic to Redis."
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress_with_source_security_group_id = [
    for sg in var.ingress_security_group_ids : {
      from_port                = var.port
      to_port                  = var.port
      protocol                 = "tcp"
      description              = "Redis port"
      source_security_group_id = sg
    }
  ]

  egress_rules = ["all-all"]
}

resource "aws_elasticache_subnet_group" "default" {
  name       = var.resource_name != "" ? var.resource_name : local.name
  subnet_ids = var.subnets
}

resource "aws_elasticache_parameter_group" "redis_parameter_group" {
  name   = var.resource_name != "" ? var.resource_name : local.name
  family = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameters

    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }
}

resource "random_password" "redis_db" {
  length  = 32
  special = false
}

resource "aws_elasticache_replication_group" "default" {
  replication_group_id        = var.resource_name != "" ? var.resource_name : local.name
  description                 = var.description
  engine                      = "redis"
  engine_version              = var.engine_version
  node_type                   = var.instance_type
  port                        = var.port
  num_cache_clusters          = var.number_cache_clusters
  parameter_group_name        = aws_elasticache_parameter_group.redis_parameter_group.name
  subnet_group_name           = aws_elasticache_subnet_group.default.name
  security_group_ids          = [module.sg.security_group_id]
  apply_immediately           = var.apply_immediately
  at_rest_encryption_enabled  = var.at_rest_encryption_enabled
  transit_encryption_enabled  = var.transit_encryption_enabled
  preferred_cache_cluster_azs = var.preferred_cache_cluster_azs
  auth_token                  = random_password.redis_db.result
  tags                        = var.tags
}
