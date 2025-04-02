# secrets setup

This module does the work of preparing an AWS account to use [Chamber](https://github.com/segmentio/chamber) for managing secrets.

Currently that just means creating an KMS key for encrypting the parameters store entries.


<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.17.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.parameter_store_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.parameter_store](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias_name"></a> [alias\_name](#input\_alias\_name) | Chamber is hard coded to use a KMS alias with the name 'parameter\_store\_key'. | `string` | `"parameter_store_key"` | no |
| <a name="input_env"></a> [env](#input\_env) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | `""` | no |

## Outputs

No outputs.
<!-- END -->
