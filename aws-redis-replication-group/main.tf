locals {
  name = "${var.project}-${var.env}-${var.service}"

  tags = {
    managedBy = "terraform"
    Name      = "${var.project}-${var.env}-${var.service}"
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
  }
}

module "sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.3.0"
  name        = local.name
  description = "Allow traffic to Redis."
  vpc_id      = var.vpc_id
  tags        = local.tags

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

resource "aws_elasticache_replication_group" "default" {
  replication_group_id          = var.resource_name != "" ? var.resource_name : local.name
  replication_group_description = var.replication_group_description
  engine                        = "redis"
  engine_version                = var.engine_version
  node_type                     = var.instance_type
  port                          = var.port
  number_cache_clusters         = var.number_cache_clusters
  parameter_group_name          = var.parameter_group_name
  subnet_group_name             = aws_elasticache_subnet_group.default.name
  security_group_ids            = [module.sg.security_group_id]
  apply_immediately             = var.apply_immediately
  at_rest_encryption_enabled    = var.at_rest_encryption_enabled
  transit_encryption_enabled    = var.transit_encryption_enabled
  availability_zones            = var.availability_zones
  tags                          = local.tags
}
