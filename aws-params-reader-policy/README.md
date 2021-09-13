# Secrets Policy

Creates a policy to access encrypted parameters in Parameter Store for a given service (or prefix).

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
| extra\_services | Extra services to be given parameter read access to, within the same project and environment. | `list(string)` | `[]` | no |
| parameter\_store\_key\_alias | Alias of the encryption key used to encrypt parameter store values. | `string` | `"parameter_store_key"` | no |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| region | Region the parameter store values can be read from. Defaults to all. | `string` | `"*"` | no |
| role\_name | Name of the role to assign the policy to. | `string` | n/a | yes |
| service | Name of the service to load secrets for. | `string` | n/a | yes |

## Outputs

No output.

<!-- END -->
