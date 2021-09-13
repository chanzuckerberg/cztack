# AWS IAM group for console login

This module will create an IAM group and grant access for its members to log into the AWS console and manage their own credentials (and nothing more).

## Example 

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-group-console-login?ref=v0.14.0"

  group_name = "..."
  iam_path   = "..."
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
| group\_name | Name of the group to be created. | `string` | `"console-login"` | no |
| iam\_path | IAM path under which resources will be created. | `string` | `"/"` | no |

## Outputs

| Name | Description |
|------|-------------|
| group\_name | n/a |

<!-- END -->
