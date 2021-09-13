# AWS SSM Params Writer

This module will set encrypted string parameters in the AWS SSM parameter store. Designed to be used in combination with
[Chamber](https://github.com/segmentio/chamber) to send variables that are output by a Terraform run to a process via
environment variables.

Parameters are stored in AWS SSM Parameter store at the path `/{project}-{env}-{service}/{name}` where name
is each of the keys of the parameters input.

**WARNING:** These parameters will stored **unencrypted** in the Terraform state file. See more about this issue
in the [Terraform docs](https://www.terraform.io/docs/state/sensitive-data.html).

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
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| parameters | Map from parameter names to values to set. | `map(string)` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |

## Outputs

No output.

<!-- END -->
