# AWS IAM Role security-audit

This will create a role for doing security audits, assumeable from `source_account_id`.

## Example

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-group-assume-role?ref=v0.11.0"

  source_account_id = "..."
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path |  | string | `/` | no |
| role_name | The name of this role. | string | `security-audit` | no |
| source_account_id | The AWS account from which this role should be assumeable. | string | - | yes |

<!-- END -->
