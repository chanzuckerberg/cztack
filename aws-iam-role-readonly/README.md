# AWS IAM Role readonly

This will create a readonly role, assumeable from `source_account_id`.

## Example

```hcl
module "role" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-role-readonly?ref=v0.14.0"

  # defaults to 'readonly'
  role_name = "..."

  # The ID of the other AWS account that can assume this role.
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
| iam\_path | - | string | `/` | no |
| role\_name | - | string | `readonly` | no |
| source\_account\_id | The AWS account from which this role should be assumeable. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | - |
| role\_name | - |

<!-- END -->
