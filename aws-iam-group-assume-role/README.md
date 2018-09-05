# AWS IAM Group for assuming a role

This module will create a group which has the right to assume a particular IAM role.  This is commoly used for granting cross-account permissions to IAM users.

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-group-assume-role?ref=v0.14.0"

  group_name      = "..."
  iam_path        = "..."
  target_accounts = [...]
  target_role     = "..."

  depends_on = ...
}

output "group_arn" {
  value = "${module.group.group_arn}"
}

output "group_name" {
  value = "${module.group.group_name}"
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| depends_on | Pseudo depends_on because Terraform modules do not support depends_on | list | `<list>` | no |
| group_name | The name of the group this module will create. | string | - | yes |
| iam_path | The IAM path under which the group and policies will be created. Useful for avoiding naming conflicts. | string | `/` | no |
| target_accounts | List of accounts in which this role should be assume-able. | list | - | yes |
| target_role | Name of the role to be assume-able. If not specified or given as empty string, then the group name will be used as the role name. | string | `` | no |
| users | List of user's names who should be added to this group. | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| group_arn |  |
| group_name |  |

<!-- END -->
