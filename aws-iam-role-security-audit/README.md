# AWS IAM Role security-audit

This will create a role for doing security audits, assumeable from `source_account_id`.

## Example

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-group-assume-role?ref=v0.14.0"

  source_account_id = "..."
}
```

<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam\_path |  | string | `"/"` | no |
| role\_name | The name of this role. | string | `"security-audit"` | no |
| source\_account\_id | The source AWS account to establish a trust relationship. Ignored if empty or not provided. | string | '' | no |
| saml\_idp\_arn | The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided. | string | '' | no |

<!-- END -->
