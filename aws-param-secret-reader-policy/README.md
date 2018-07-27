# Secrets Policy

Creates a policy to access encrypted parameters in Parameter Store for a given service (or prefix).

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account_id | The account id for the policy. | string | - | yes |
| env |  | string | - | yes |
| iam_path |  | string | `/` | no |
| parameter_store_key_alias | Alias of the encryption key used to encrypt parameter store values. | string | `parameter_store_key` | no |
| project |  | string | - | yes |
| service | Name of the service to load secrets for. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| policy_arn |  |

<!-- END -->
