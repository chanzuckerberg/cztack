locals {
  name = substr("${var.tags.project}-${var.tags.env}${var.vpc_name_suffix}", 0, 63)

  tags = merge(var.tags, {
    managedBy = "terraform"
    Name      = local.name
  })

  vpc_base_tags = { for k, v in local.tags : k => v if k != "Name" }

  k8s_tags = {
    for cluster in var.k8s_cluster_names : "kubernetes.io/cluster/${cluster}" => "shared"
  }

  k8s_karpenter_tags = merge(
    # NOTE: just making backwards compatible with the old way of doing things
    # the object below makes is so that tag is unique per cluster and we can annotate
    # the VPC with multiple clusters
    (length(var.k8s_cluster_names) == 0 ? {} : { "karpenter.sh/discovery" = var.k8s_cluster_names[0] }),
    {
      for cluster in var.k8s_cluster_names : "karpenter.sh/discovery/${cluster}" => cluster
  })

  private_subnet_tags = merge(local.k8s_tags, local.k8s_karpenter_tags, { "kubernetes.io/role/internal-elb" = 1 })
  public_subnet_tags  = merge(local.k8s_tags, { "kubernetes.io/role/elb" = 1 })

  default_ingress = [
    {
      "action" : "allow",
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 0,
      "protocol" : "-1",
      "rule_no" : 100,
      "to_port" : 0
    },
    {
      "action" : "allow",
      "from_port" : 0,
      "ipv6_cidr_block" : "::/0",
      "protocol" : "-1",
      "rule_no" : 101,
      "to_port" : 0
    }
  ]
}

resource "terraform_data" "azs_length_check_public" {
  lifecycle {
    precondition {
      condition     = var.skip_az_checks || length(var.azs) == length(var.public_subnet_cidrs)
      error_message = "Number of public subnets (${length(var.public_subnet_cidrs)}) has to match the number of availability zones (${length(var.azs)})."
    }
  }
}

resource "terraform_data" "azs_length_check_private" {
  lifecycle {
    precondition {
      condition     = var.skip_az_checks || length(var.azs) == length(var.private_subnet_cidrs)
      error_message = "Number of private subnets (${length(var.private_subnet_cidrs)}) has to match the number of availability zones (${length(var.azs)})."
    }
  }
}

resource "terraform_data" "azs_length_check_database" {
  lifecycle {
    precondition {
      condition     = var.skip_az_checks || length(var.azs) == length(var.database_subnet_cidrs)
      error_message = "Number of database subnets (${length(var.database_subnet_cidrs)}) has to match the number of availability zones (${length(var.azs)})."
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = local.name

  cidr             = var.vpc_cidr
  azs              = var.azs
  private_subnets  = var.private_subnet_cidrs
  public_subnets   = var.public_subnet_cidrs
  database_subnets = var.database_subnet_cidrs

  enable_nat_gateway      = true
  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true

  create_database_subnet_group       = true
  create_database_subnet_route_table = var.create_database_subnet_route_table

  tags = local.vpc_base_tags

  # Add extra tags to subnets, particularly for eks/k8s
  vpc_tags            = local.private_subnet_tags
  private_subnet_tags = local.private_subnet_tags
  public_subnet_tags  = local.public_subnet_tags
  single_nat_gateway  = var.single_nat_gateway

  default_network_acl_ingress = local.default_ingress

  depends_on = [
    terraform_data.azs_length_check_public,
    terraform_data.azs_length_check_private,
    terraform_data.azs_length_check_database,
  ]
}

resource "aws_default_security_group" "default" {
  vpc_id = module.vpc.vpc_id
  tags = merge(var.tags, {
    managedBy = "terraform"
    Name      = "${local.name}-default"
  })
}
