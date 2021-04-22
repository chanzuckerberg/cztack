# Secrets Policy

Creates a policy to access encrypted parameters in Parameter Store for a given service (or prefix).

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | < 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_alias.parameter_store_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_extra_services"></a> [extra\_services](#input\_extra\_services) | Extra services to be given parameter read access to, within the same project and environment. | `list(string)` | `[]` | no |
| <a name="input_parameter_store_key_alias"></a> [parameter\_store\_key\_alias](#input\_parameter\_store\_key\_alias) | Alias of the encryption key used to encrypt parameter store values. | `string` | `"parameter_store_key"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region the parameter store values can be read from. Defaults to all. | `string` | `"*"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the role to assign the policy to. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Name of the service to load secrets for. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END -->
