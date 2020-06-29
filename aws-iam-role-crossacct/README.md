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
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| iam\_path | The IAM path to put this role in. | `string` | `"/"` | no |
| max\_session\_duration | The maximum session duration (in seconds) for the role. | `number` | `3600` | no |
| oidc | A list of AWS OIDC IDPs to establish a trust relationship for this role. | <pre>list(object(<br>    {<br>      idp_arn : string,          # the AWS IAM IDP arn<br>      client_ids : list(string), # a list of oidc client ids<br>      provider : string          # your provider url, such as foo.okta.com<br>    }<br>  ))</pre> | `[]` | no |
| role\_name | The name of the role. | `string` | n/a | yes |
| saml\_idp\_arn | The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided. | `string` | `""` | no |
| source\_account\_id | The source AWS account to establish a trust relationship. Ignored if empty or not provided. DEPRECATED: Please use source\_account\_ids. | `string` | `""` | no |
| source\_account\_ids | The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |
| tags | A map of tags to assign this IAM Role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam\_path | n/a |
| role\_arn | n/a |
| role\_name | n/a |

<!-- END -->
