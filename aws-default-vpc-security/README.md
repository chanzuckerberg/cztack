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

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_sg\_lockdown | Restrict default security group to deny all traffic (you can selectively enable traffic with other security groups). | `bool` | `true` | no |

## Outputs

No output.

<!-- END -->
