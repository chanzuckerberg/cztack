# AWS Role infraci

Creates a role useful for running `terraform plan` in CI jobs.

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path |  | string | `/` | no |
| role_name |  | string | `infraci` | no |
| source_account_id |  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| role_name |  |

<!-- END -->
