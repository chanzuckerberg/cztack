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
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| iam\_path | n/a | `string` | `"/"` | no |
| role\_name | n/a | `string` | `"readonly"` | no |
| saml\_idp\_arn | The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided. | `string` | `""` | no |
| source\_account\_id | The source AWS account to establish a trust relationship. Ignored if empty or not provided. DEPRECATED: Please use source\_account\_ids. | `string` | `""` | no |
| source\_account\_ids | The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| role\_name | n/a |

<!-- END -->
