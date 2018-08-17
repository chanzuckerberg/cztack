# AWS EC2 poweruser

This module will create a role, assumeable by another account, which has EC2 Poweruser priviledges.

## Example

```hcl
module "ec2-poweruser" {
  source = "github.com/chanzuckerberg/cztack//aws-iam-role-ec2-poweruser?ref=v0.12.0"

  # The name of the role to create in this account.
  role_name = "..."

  # The ID of the other AWS account which can assume this role.
  source_account_id = "..."
}

```


<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path |  | string | `/` | no |
| role_name |  | string | - | yes |
| source_account_id |  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| role_name |  |

<!-- END -->
