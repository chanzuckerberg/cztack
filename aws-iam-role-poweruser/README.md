# AWS IAM role poweruser

This creates a role, `role_name` which is assumable from the account `source_account_id`.

## Example

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-role-poweruser?ref=master" # FIXME

  role_name         = "…" # defaults to "poweruser"
  source_account_id = "…"
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| role_name |  | string | `poweruser` | no |
| source_account_id |  | string | - | yes |

<!-- END -->
