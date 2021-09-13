# AWS Cloudwatch Log Group

This module will create a new Cloudwatch Log group and tag it appropriately.

By default the name is `${var.project}-${var.env}-${var.service}`, but you can override that by setting `var.log_group_name`.

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
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| log\_group\_name | Name for the log group. If not set, it will be $project-$env-$service} | `string` | `""` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| retention\_in\_days | N of days you want to retain log events. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. | `number` | `0` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| name | n/a |

<!-- END -->
