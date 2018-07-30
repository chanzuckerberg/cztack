# AWS Default VPC security

This module will name, tag and optionally lock down traffic to AWS Default VPCs.

## Example

```hcl
module "default-vpc" {
  source = "github.com/chanzuckerberg/cztack/aws-default-vpc-lockdown?ref=master"
  
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
  source = "github.com/chanzuckerberg/cztack/aws-default-vpc-lockdown?ref=master"

  default_sg_lockdown = true

  providers {
    "aws" = "aws.us-west-1"
  }
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| default_sg_lockdown | Restrict default security group to deny all traffic (you can selectively enable traffic with other security groups). | string | `true` | no |

<!-- END -->
