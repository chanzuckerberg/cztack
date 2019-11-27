# AWS IAM role poweruser

This creates a role, `role_name` which is assumable from the account `source_account_id`.

## Example

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-role-poweruser?ref=v0.14.0"

  # defaults to "poweruser"
  role_name         = "..."

  # The id of the other AWS account that can assume this role.
  source_account_id = "..."
}
```

<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam\_path |  | string | `"/"` | no |
| role\_name |  | string | `"poweruser"` | no |
| source\_account\_id | The source AWS account to establish a trust relationship. Ignored if empty or not provided. | string | '' | no |
| saml\_idp\_arn | The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided. | string | '' | no |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| role\_name |  |

<!-- END -->
