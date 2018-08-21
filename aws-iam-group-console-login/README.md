# AWS IAM group for console login

This module will create an IAM group and grant access for its members to log into the AWS console and manage their own credentials (and nothing more).

## Example 

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-group-console-login?ref=v0.13.0"

  group_name = "..."
  iam_path   = "..."
}

output "group_name" {
  value = "${module.group.group_name}"
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| group_name | Name of the group to be created. | string | `console-login` | no |
| iam_path | IAM path under which resources will be created. | string | `/` | no |

## Outputs

| Name | Description |
|------|-------------|
| group_name |  |

<!-- END -->
