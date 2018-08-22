# Secrets Policy

Creates a policy to access encrypted parameters in Parameter Store for a given service (or prefix).

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| iam_path |  | string | `/` | no |
| parameter_store_key_alias | Alias of the encryption key used to encrypt parameter store values. | string | `parameter_store_key` | no |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| region | Region the parameter store values can be read from. Defaults to all. | string | `*` | no |
| role_name | Name of the role to assign the policy to. | string | - | yes |
| service | Name of the service to load secrets for. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| policy_arn |  |

<!-- END -->
