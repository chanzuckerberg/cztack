# AWS IAM Role Cloudfront Poweruser

This module will create a role which is granted poweruser control over AWS CLoudfront.


<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path |  | string | `/` | no |
| role_name |  | string | - | yes |
| s3_bucket_prefix | Limits role permissions to buckets with specific prefix. Empty string for all buckets. | string | `` | no |
| source_account_id |  | string | - | yes |

<!-- END -->
