# AWS IAM role poweruser

This creates a role, `role_name` which is assumable from the account `source_account_id`.

## Example

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-role-poweruser?ref=v0.14.0"

  # defaults to "poweruser"
  role_name         = "..."

  # The id of the other AWS account that can assume this role.
  source_account_id = "..."
}
```

<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.17.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_assume_role_policy"></a> [assume\_role\_policy](#module\_assume\_role\_policy) | ../aws-assume-role-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.misc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.poweruser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.misc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.poweruser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.misc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorize_iam"></a> [authorize\_iam](#input\_authorize\_iam) | Indicates if we should augment the PowerUserAccess policy with certain IAM actions. | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | IAM path for the role. | `string` | `"/"` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | The maximum session duration (in seconds) for the role. | `number` | `3600` | no |
| <a name="input_oidc"></a> [oidc](#input\_oidc) | A list of AWS OIDC IDPs to establish a trust relationship for this role. | <pre>list(object(<br>    {<br>      idp_arn : string,          # the AWS IAM IDP arn<br>      client_ids : list(string), # a list of oidc client ids<br>      provider : string          # your provider url, such as foo.okta.com<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | n/a | `string` | `"poweruser"` | no |
| <a name="input_saml_idp_arns"></a> [saml\_idp\_arns](#input\_saml\_idp\_arns) | The AWS SAML IDP arns to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_source_account_ids"></a> [source\_account\_ids](#input\_source\_account\_ids) | The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
<!-- END -->
