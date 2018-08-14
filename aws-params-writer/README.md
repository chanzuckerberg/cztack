# AWS Params Writer

This module sets encrypted string parameters in the AWS SSM parameter store. Indented to be used combination with [Chamber](https://github.com/segmentio/chamber)
to send variables that are output by a Terraform run to a process via environment variables.

Parameters are stored in AWS SSM Parameter store at the path `/{project}-{env}-{service}/{name}` where name
is each of the keys of the parameters input.

Note that these values will be stored unencrypted in the Terraform state file. See [this doc](https://www.terraform.io/docs/state/sensitive-data.html) for more info

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| parameters | Map from parameter names to values to set. | map | - | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |

<!-- END -->
