# AWS cross-account role module

This module makes it easy to define a role assumeable by another AWS account. Like [this](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html).

## Example

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack//aws-iam-role-crossacct?ref=v0.14.0"

  # The name of the role to create (in this account).
  role_name = "..."

  # The id of the other account that can assume this role.
  source_account_id = "..."
}
```

<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam\_path | The IAM path to put this role in. | string | `"/"` | no |
| role\_name | The name of the role. | string | n/a | yes |
| source\_account\_id | The AWS account id that should be able to assume this role. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam\_path |  |
| role\_name |  |

<!-- END -->
