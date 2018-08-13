# AWS IAM Role Cloudfront Poweruser

This module will create a role which is granted poweruser control over AWS Cloudfront.

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path |  | string | `/` | no |
| role_name | Name of the role to create | string | - | yes |
| s3_bucket_prefix | Limits role permissions to buckets with specific prefix. Empty string for all buckets. | string | `` | no |
| source_account_id | AWS Account that can assume this role. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| role_arn |  |
| role_name |  |

<!-- END -->
