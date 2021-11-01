# AWS Params Writer (DEPRECATED)

__*Deprecated. Please use `aws-ssm-params-writer` module for new code*__

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
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_kms_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Map from parameter names to values to set. | `map(any)` | n/a | yes |
| <a name="input_parameters_count"></a> [parameters\_count](#input\_parameters\_count) | HACK: The number of keys in var.parameters. To avoid hitting value of count cannot be computed. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END -->
