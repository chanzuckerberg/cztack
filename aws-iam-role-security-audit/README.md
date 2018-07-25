# AWS IAM Role security-audit

This will create a role for doing security audits, assumeable from `source_account_id`.


## Example

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-group-assume-role?ref=master" # FIXME

  source_account_id = "…"
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| role_name | The name of this role. | string | `/` | no |
| source_account_id | The AWS account from which this role should be assumeable. | string | - | yes |

<!-- END -->
