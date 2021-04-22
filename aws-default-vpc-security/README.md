# AWS Default VPC security

This module will name, tag and optionally lock down traffic to AWS Default VPCs.

## Example

```hcl
module "default-vpc" {
  source = "github.com/chanzuckerberg/cztack/aws-default-vpc-lockdown?ref=v0.14.0"
  
  # Lock down the default security group in the default VPC to deny all traffic.
  default_sg_lockdown = true
}
```

Note that you might want to do this per region. To do so, you can override the provider like so–

```hcl
provider "aws"{
  region = "us-west-1"
  alias  = "us-west-1"
  ...
}

module "default-vpc" {
  source = "github.com/chanzuckerberg/cztack/aws-default-vpc-lockdown?ref=v0.14.0"

  default_sg_lockdown = true

  providers = {
    "aws" = "aws.us-west-1"
  }
}
```

You will need to invoke this module with a properly configured provider for every region you want to lock down.

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | < 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_network_acl.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl) | resource |
| [aws_default_route_table.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_default_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_subnet) | resource |
| [aws_default_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_internet_gateway.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/internet_gateway) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_sg_lockdown"></a> [default\_sg\_lockdown](#input\_default\_sg\_lockdown) | Restrict default security group to deny all traffic (you can selectively enable traffic with other security groups). | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END -->
