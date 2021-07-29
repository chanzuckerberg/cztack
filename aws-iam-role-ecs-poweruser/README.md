# AWS IAM role for ECS Poweruser

This module will create a role, assumeable by another account, which has ECS Poweruser priviledges.

## Example

```hcl
module "ec2-poweruser" {
  source = "github.com/chanzuckerberg/cztack//aws-iam-role-ecs-poweruser?ref=v0.36.0"

  # The name of the role to create in this account.
  role_name = "..."

  # The ID of the other AWS account which can assume this role.
  source_account_id = "..."
}

```

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
| [aws_iam_policy.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs-poweruser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecr-poweruser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs-fullaccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | n/a | `string` | `"/"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | n/a | `string` | n/a | yes |
| <a name="input_saml_idp_arns"></a> [saml\_idp\_arns](#input\_saml\_idp\_arns) | The AWS SAML IDP arns to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_source_account_id"></a> [source\_account\_id](#input\_source\_account\_id) | The source AWS account to establish a trust relationship. Ignored if empty or not provided. DEPRECATED: Please use source\_account\_ids. | `string` | `""` | no |
| <a name="input_source_account_ids"></a> [source\_account\_ids](#input\_source\_account\_ids) | The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
<!-- END -->
