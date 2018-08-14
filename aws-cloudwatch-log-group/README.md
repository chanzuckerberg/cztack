<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| log_group_name | Name for the log group. If not set, it will be $project-$env-$service} | string | `` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| name |  |

<!-- END -->
