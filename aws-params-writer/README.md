Sets unencrypted string parameters in the AWS SSM parameter store. Often used in combination with Chamber
to send variables that are output by a Terraform run to a process via environment variables.

Parameters are stored in AWS SSM Parameter store at the path `/{project}-{env}-{service}/{name}` where name
is each of the keys of the parameters input.

https://www.terraform.io/docs/state/sensitive-data.html

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | The project name (probably same as team). | string | - | yes |
| env | The cloud env (ie staging, production). | string | - | yes |
| service | The service name. | string | - | yes |
| parameters | Map from parameter names to values to set. | map | - | yes |

## Outputs

| Name | Description |
|------|-------------|

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
