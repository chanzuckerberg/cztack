# AWS IAM group for ssh

This module will create an IAM group that is used by Bless to verify ssh certificate principals.

## Example

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-group-bless?ref=master"

  principal_name = "…"
  iam_path = "…"
  users = ["..."]
}

output "group_name" {
  value = "${module.group.group_name}"
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path | IAM path under which resources will be created. | string | `/` | no |
| principal_name | Name of the ssh principal this group authorizes. | string | - | yes |
| users | The IAM Users to add to this group. | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| group_name |  |

<!-- END -->
