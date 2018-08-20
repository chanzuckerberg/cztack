# AWS IAM Role Cloudfront Poweruser

This module will create a role which is granted poweruser control over AWS Cloudfront.

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path |  | string | `/` | no |
| role_name | Name of the role to create | string | - | yes |
| s3_bucket_prefixes | Limits role permissions to buckets with specific prefixes. Empty for all buckets. | string | `<list>` | no |
| source_account_id | AWS Account that can assume this role. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| role_arn |  |
| role_name |  |

<!-- END -->
