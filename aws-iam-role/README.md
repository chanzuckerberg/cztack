# aws-iam-role
A module for creating an IAM role with the inline policies and managed policies attached to the role.

## Example

```hcl
module iam-role {
  source = "github.com/chanzuckerberg/cztack//aws-iam-role?ref=..."

  principals = [
    {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  ]

  role_name              = "..."
  role_description       = "...."
  attached_policies_arns = [aws_iam_policy.policy.arn]

  owner   = var.owner
  project = var.project
  service = var.component
  env     = var.env
}
```

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
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attached_policies_names_arns"></a> [attached\_policies\_names\_arns](#input\_attached\_policies\_names\_arns) | Map of policy names to the respective ARNs to be attached to the IAM role. | `map(string)` | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | The IAM path under which the IAM role will be created. | `string` | `null` | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | List of inline policies to be associated with the IAM role. | `list(object({ name = string, policy = string }))` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | The maximum amount of time, in seconds, that a principal can assume this role. | `number` | `3600` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_principals"></a> [principals](#input\_principals) | AWS IAM Principals which will be able to assume this role. | `list(object({ type = string, identifiers = list(string) }))` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM role description. | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | IAM role name. | `string` | n/a | yes |
| <a name="input_saml_idp_arn"></a> [saml\_idp\_arn](#input\_saml\_idp\_arn) | The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided. | `string` | `""` | no |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | IAM role ARN. |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | IAM role name. |
<!-- END -->
