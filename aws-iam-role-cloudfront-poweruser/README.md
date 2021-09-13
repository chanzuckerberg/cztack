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
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| iam\_path | n/a | `string` | `"/"` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| role\_name | Name of the role to create | `string` | n/a | yes |
| s3\_bucket\_prefixes | Limits role permissions to buckets with specific prefixes. Empty for all buckets. | `list(any)` | <pre>[<br>  ""<br>]</pre> | no |
| saml\_idp\_arns | The AWS SAML IDP arns to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| source\_account\_ids | The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_arn | n/a |
| role\_name | n/a |

<!-- END -->
