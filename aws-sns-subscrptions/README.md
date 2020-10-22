# AWS-SNS-SUBSCRIPTIONS
A module to integrate AWS SNS topic and topic subscription to various endpoints.

## Example

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| aws | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| sns\_configurations | List of objects containing the SNS configurations. | `list(any)` | `[]` | no |
| sns\_topic\_name | SNS topic name. If not provided, use $project-$env-$service by default. | `string` | n/a | yes |

## Outputs

No output.

<!-- END -->
