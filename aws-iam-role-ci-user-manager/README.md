<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_assume_role_policy"></a> [assume\_role\_policy](#module\_assume\_role\_policy) | ../aws-assume-role-policy |  |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.ci-manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ci-manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ci-manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_caller_account_id"></a> [caller\_account\_id](#input\_caller\_account\_id) | The account\_id we delegate access to | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. | `string` | n/a | yes |
| <a name="input_sts_external_id"></a> [sts\_external\_id](#input\_sts\_external\_id) | Nonsensitive identifier for delegating third party access. More about it [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html).<br>  The Condition statement will look like this: `"Condition": {"StringEquals": {"sts:ExternalId": var.sts_external_id}}` | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
<!-- END -->