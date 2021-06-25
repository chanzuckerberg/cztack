# Normally we don't specify providers in modules (TODO link to infra guide), but
# we do this to enable running this for each region, example–
#  ``` module "..." {
#   ...
#   providers = {
#     'aws' = 'aws.us-west-1'
#   }
# }
# ```
provider "aws" {}

data "aws_availability_zones" "available" {}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_default_vpc.default.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.default.id
  }

  tags = {
    Name = "Default Route Table"
  }
}

# count hack here based on https://github.com/hashicorp/terraform/issues/11574#issuecomment-365690226
# :(
resource "aws_default_subnet" "default" {
  count = length(split(",", join(",", flatten(data.aws_availability_zones.available.*.names))))

  availability_zone = data.aws_availability_zones.available.names[count.index]
}

# Re-attach default subnets to the default netowrk ACL to avoid this issue–
# https://github.com/hashicorp/terraform/issues/9824
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_default_vpc.default.default_network_acl_id
  subnet_ids             = aws_default_subnet.default.*.id

  # According to https://www.terraform.io/docs/providers/aws/r/default_network_acl.html
  # these are the default rules (ie allow all).
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Default Network ACL"
  }
}

resource "aws_default_security_group" "default" {
  count  = var.default_sg_lockdown ? 1 : 0
  vpc_id = aws_default_vpc.default.id

  # No ingress or egress here means we permit no traffic.

  tags = {
    Name = "Default Security Group"
  }
}

# TODO turn on flow logs for default vpc
#   https://app.asana.com/0/335732894489412/503937337513570
# resource "aws_flow_log" "default_vpc_flow_logs" {
#   log_group_name =  var.vpc_flow_logs_group_name
#   iam_role_arn   =  var.vpc_flow_logs_iam_role_arn
#   vpc_id         =  aws_default_vpc.default.id
#   traffic_type   = "ALL"
# }

