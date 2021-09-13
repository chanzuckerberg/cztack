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
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| authorize\_iam | Indicates if we should augment the PowerUserAccess policy with certain IAM actions. | `bool` | `true` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| iam\_path | IAM path for the role. | `string` | `"/"` | no |
| max\_session\_duration | The maximum session duration (in seconds) for the role. | `number` | `3600` | no |
| oidc | A list of AWS OIDC IDPs to establish a trust relationship for this role. | <pre>list(object(<br>    {<br>      idp_arn : string,          # the AWS IAM IDP arn<br>      client_ids : list(string), # a list of oidc client ids<br>      provider : string          # your provider url, such as foo.okta.com<br>    }<br>  ))</pre> | `[]` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| role\_name | n/a | `string` | `"poweruser"` | no |
| saml\_idp\_arns | The AWS SAML IDP arns to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| source\_account\_ids | The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| role\_name | n/a |

<!-- END -->
