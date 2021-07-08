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

  ingress_with_cidr_blocks = [
    for cidr_block in var.ingress_security_group_cidr_blocks : {
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      description = "Redis port"
      cidr_blocks = cidr_block
    }
  ]

  egress_rules = ["all-all"]
}

resource "aws_elasticache_subnet_group" "default" {
  name       = var.resource_name != "" ? var.resource_name : local.name
  subnet_ids = var.subnets
}

resource "aws_elasticache_cluster" "default" {
  cluster_id           = var.resource_name != "" ? var.resource_name : local.name
  engine               = "redis"
  engine_version       = var.engine_version
  node_type            = var.instance_type
  port                 = var.port
  num_cache_nodes      = 1
  parameter_group_name = var.parameter_group_name
  subnet_group_name    = aws_elasticache_subnet_group.default.name
  security_group_ids   = [module.sg.security_group_id]
  apply_immediately    = var.apply_immediately
  availability_zone    = var.availability_zone
  tags                 = local.tags
}
