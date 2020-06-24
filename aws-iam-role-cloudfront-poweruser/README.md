# AWS IAM Role Cloudfront Poweruser

This module will create a role which is granted poweruser control over AWS Cloudfront.

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
| iam\_path | n/a | `string` | `"/"` | no |
| role\_name | Name of the role to create | `string` | n/a | yes |
| s3\_bucket\_prefixes | Limits role permissions to buckets with specific prefixes. Empty for all buckets. | `list` | <pre>[<br>  ""<br>]</pre> | no |
| saml\_idp\_arn | The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided. | `string` | `""` | no |
| source\_account\_id | The source AWS account to establish a trust relationship. Ignored if empty or not provided. DEPRECATED: Please use source\_account\_ids. | `string` | `""` | no |
| source\_account\_ids | The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |
| tags | A map of tags to assign this IAM Role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_arn | n/a |
| role\_name | n/a |

<!-- END -->
