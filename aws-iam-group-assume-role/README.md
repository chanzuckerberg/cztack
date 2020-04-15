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
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dependencies | Pseudo depends\_on because Terraform modules do not support depends\_on | `list` | `[]` | no |
| group\_name | The name of the group this module will create. | `string` | n/a | yes |
| iam\_path | The IAM path under which the group and policies will be created. Useful for avoiding naming conflicts. | `string` | `"/"` | no |
| target\_accounts | List of accounts in which this role should be assume-able. | `list` | n/a | yes |
| target\_role | Name of the role to be assume-able. If not specified or given as empty string, then the group name will be used as the role name. | `string` | `""` | no |
| users | List of user's names who should be added to this group. | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| group\_arn | n/a |
| group\_name | n/a |

<!-- END -->
