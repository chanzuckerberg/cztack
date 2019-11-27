# AWS Role infraci

Creates a role useful for running `terraform plan` in CI jobs.

<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam\_path |  | string | `"/"` | no |
| role\_name |  | string | `"infraci"` | no |
| terraform\_state\_lock\_dynamodb\_arns | "A list of unique identifiers (ARNs) of state file DynamoDB tables" | string | `[]` | yes |
| source\_account\_id | The source AWS account to establish a trust relationship. Ignored if empty or not provided. | string | '' | no |
| saml\_idp\_arn | The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided. | string | '' | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_name |  |

<!-- END -->
