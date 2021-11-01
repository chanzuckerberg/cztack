# AWS IAM Group for assuming a role

This module will create a group which has the right to assume a particular IAM role.  This is commoly used for granting cross-account permissions to IAM users.

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-group-assume-role?ref=v0.14.0"

  group_name      = "..."
  iam_path        = "..."
  target_accounts = [...]
  target_role     = "..."

  dependencies = ...
}

output "group_arn" {
  value = "${module.group.group_arn}"
}

output "group_name" {
  value = "${module.group.group_name}"
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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.assume-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.assume-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy_attachment.assume-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.assume-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.assume-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dependencies"></a> [dependencies](#input\_dependencies) | Pseudo depends\_on because Terraform modules do not support depends\_on | `list(any)` | `[]` | no |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | The name of the group this module will create. | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | The IAM path under which the group and policies will be created. Useful for avoiding naming conflicts. | `string` | `"/"` | no |
| <a name="input_target_accounts"></a> [target\_accounts](#input\_target\_accounts) | List of accounts in which this role should be assume-able. | `list(any)` | n/a | yes |
| <a name="input_target_role"></a> [target\_role](#input\_target\_role) | Name of the role to be assume-able. If not specified or given as empty string, then the group name will be used as the role name. | `string` | `""` | no |
| <a name="input_users"></a> [users](#input\_users) | List of user's names who should be added to this group. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_arn"></a> [group\_arn](#output\_group\_arn) | n/a |
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | n/a |
<!-- END -->
