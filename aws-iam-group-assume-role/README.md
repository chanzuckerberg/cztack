# AWS IAM Group for assuming a role

This module will create a grouop which has the right to assume a particular IAM role.  This is commoly used for granting cross-account permissions to IAM users.

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| depends_on | Pseudo depends_on because Terraform modules do not support depends_on | list | `<list>` | no |
| group_name |  | string | - | yes |
| path |  | string | `/` | no |
| target_accounts |  | list | - | yes |
| target_role |  | string | `` | no |
| users |  | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| group_arn |  |
| group_name |  |

<!-- END -->