# AWS Role infraci

Creates a role useful for running `terraform plan` in CI jobs.

<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam\_path |  | string | `"/"` | no |
| role\_name |  | string | `"infraci"` | no |
| source\_account\_id |  | string | n/a | yes |
| terraform\_state\_lock\_dynamodb\_arns | "A list of unique identifiers (ARNs) of state file DynamoDB tables" | string | `[]` | yes |

## Outputs

| Name | Description |
|------|-------------|
| role\_name |  |

<!-- END -->
