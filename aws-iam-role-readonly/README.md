# AWS IAM Role readonly

This will create a readonly role, assumeable from `source_account_id`.

## Example

```hcl
module "role" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-role-readonly?ref=v0.11.0"

  source_account_id = "..."
}

output "role_name" {
  value = "${module.role.role_name}"
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path |  | string | `/` | no |
| role_name |  | string | `readonly` | no |
| source_account_id | The AWS account from which this role should be assumeable. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| role_name |  |

<!-- END -->
