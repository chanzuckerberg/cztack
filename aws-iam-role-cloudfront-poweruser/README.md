# AWS IAM Role Cloudfront Poweruser

This module will create a role which is granted poweruser control over AWS Cloudfront.

<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam\_path | - | string | `/` | no |
| role\_name | Name of the role to create | string | - | yes |
| s3\_bucket\_prefixes | Limits role permissions to buckets with specific prefixes. Empty for all buckets. | list | `<list>` | no |
| source\_account\_id | AWS Account that can assume this role. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| role\_arn | - |
| role\_name | - |

<!-- END -->
