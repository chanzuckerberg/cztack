# secrets setup

This module does the work of preparing an AWS account to use [Chamber](https://github.com/segmentio/chamber) for managing secrets.

Currently that just means creating an KMS key for encrypting the parameters store entries.


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
| alias\_name | Chamber is hard coded to use a KMS alias with the name 'parameter\_store\_key'. | `string` | `"parameter_store_key"` | no |
| env | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | `""` | no |
| owner | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| service | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | `""` | no |

## Outputs

No output.

<!-- END -->
