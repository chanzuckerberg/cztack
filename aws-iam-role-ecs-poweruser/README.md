# AWS IAM role for ECS Poweruser

This module will create a role, assumeable by another account, which has ECS Poweruser priviledges.

## Example

```hcl
module "ec2-poweruser" {
  source = "github.com/chanzuckerberg/cztack//aws-iam-role-ecs-poweruser?ref=v0.14.0"

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
| iam\_path |  | string | `"/"` | no |
| role\_name |  | string | n/a | yes |
| source\_account\_id |  | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |

<!-- END -->
