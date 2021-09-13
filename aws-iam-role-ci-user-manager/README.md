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
| caller\_account\_id | The account\_id we delegate access to | `string` | n/a | yes |
| env | Env for tagging and naming. | `string` | n/a | yes |
| owner | Owner for tagging and naming. | `string` | n/a | yes |
| project | Project for tagging and naming. | `string` | n/a | yes |
| service | Service for tagging and naming. | `string` | n/a | yes |
| sts\_external\_id | Nonsensitive identifier for delegating third party access. More about it [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html).<br>  The Condition statement will look like this: `"Condition": {"StringEquals": {"sts:ExternalId": var.sts_external_id}}` | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| role\_name | n/a |

<!-- END -->