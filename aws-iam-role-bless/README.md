# AWS IAM Role - Bless client

Creates a role for use with [blessclients](https://github.com/lyft/python-blessclient).

## Example

```hcl
module "aws-iam-role-bless" {
  source = "github.com/chanzuckerberg/cztack//aws-iam-role-bless?ref=v0.36.0"

  role_name = "..."
  source_account_id = "..."
  bless_lambda_arns = "..."
}

output "..." {
  role_name = "${module.aws-iam-role-bless.role_name}"
  role_arn = "${module.aws-iam-role-bless.role_arn}"
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
| <a name="module_client"></a> [client](#module\_client) | ../aws-iam-role-crossacct |  |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy.client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_policy_document.client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bless_lambda_arns"></a> [bless\_lambda\_arns](#input\_bless\_lambda\_arns) | List of bless lambda arns | `list(any)` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | IAM path | `string` | `"/"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name for the role | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_source_account_id"></a> [source\_account\_id](#input\_source\_account\_id) | The source aws account id to allow sts:AssumeRole. DEPRECATED: Please use source\_account\_ids | `string` | n/a | yes |
| <a name="input_source_account_ids"></a> [source\_account\_ids](#input\_source\_account\_ids) | The source aws account ids to allow sts:AssumeRole | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
<!-- END -->
