# Peripheral VPC Endpoints are created here. This is a part of AWS PrivateLink infrastructure that 
# is described in this document - https://docs.aws.amazon.com/prescriptive-guidance/latest/integrate-third-party-services/architecture-1.html.
# Only https traffic is allowed to the VPC endpoints.

data "aws_availability_zone" "vpc_azs" {
  for_each = toset(var.azs)
  name     = each.value
}

locals {
  enabled_vpc_endpoints = {
    for idx, endpoint in var.vpc_endpoints : endpoint.service => merge(endpoint, {
      region = try(endpoint.region, "us-west-2")
    })
    if endpoint.enabled
  }

  # Build a map from AZ name to AZ ID using static var.azs (known at plan time)
  az_name_to_id = {
    for az_name, az in data.aws_availability_zone.vpc_azs : az_name => az.zone_id
  }

  # Indices of private subnets whose AZ is in the supported list.
  # var.azs[i] corresponds to module.vpc.private_subnets[i].
  vpc_endpoint_subnet_indices = {
    for service, endpoint in local.enabled_vpc_endpoints : service => (
      length(endpoint.supported_az_ids) > 0
      ? [for i, az in var.azs : i if contains(endpoint.supported_az_ids, local.az_name_to_id[az])]
      : range(length(var.azs))
    )
  }
}

resource "aws_security_group" "vpc_endpoint" {
  for_each    = local.enabled_vpc_endpoints
  name_prefix = "${local.tags.env}-${local.tags.service}-${each.key}-vpc-endpoint-"
  description = "Security group for ${each.key} VPC endpoint"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${local.tags.env}-${local.tags.service}-${each.key}-vpc-endpoint"
  })
}

resource "aws_vpc_endpoint" "vpc_endpoints" {
  for_each          = local.enabled_vpc_endpoints
  vpc_id            = module.vpc.vpc_id
  service_name      = each.value.service
  vpc_endpoint_type = "Interface"
  subnet_ids = [
    for i in local.vpc_endpoint_subnet_indices[each.key] : module.vpc.private_subnets[i]
  ]
  security_group_ids = [aws_security_group.vpc_endpoint[each.key].id]
  service_region     = each.value.region

  private_dns_enabled = true

  tags = merge(local.tags, {
    Name = "${local.tags.env}-${local.tags.service}-${each.key}-vpc-endpoint"
  })
}

