# aws-iam-role
A module for creating an IAM role with the inline policies and managed policies attached to the role.

## Example

```hcl
module iam-role {
  source = "github.com/chanzuckerberg/cztack//aws-iam-role?ref=..."

  principals = [
    {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  ]

  role_name              = "..."
  role_description       = "...."
  attached_policies_arns = [aws_iam_policy.policy.arn]

  owner   = var.owner
  project = var.project
  service = var.component
  env     = var.env
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
| attached\_policies\_names\_arns | Map of policy names to the respective ARNs to be attached to the IAM role. | `map(string)` | `{}` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| iam\_path | The IAM path under which the IAM role will be created. | `string` | `null` | no |
| inline\_policies | List of inline policies to be associated with the IAM role. | `list(object({ name = string, policy = string }))` | `[]` | no |
| max\_session\_duration | The maximum amount of time, in seconds, that a principal can assume this role. | `number` | `3600` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| principals | AWS IAM Principals which will be able to assume this role. | `list(object({ type = string, identifiers = list(string) }))` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| role\_description | IAM role description. | `string` | `null` | no |
| role\_name | IAM role name. | `string` | n/a | yes |
| saml\_idp\_arns | The AWS SAML IDP arns to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |
| saml\_idps | The AWS SAML IDPs to establish a trust relationship.<br>  Ignored if empty or missing."<br>  If unsure, saml\_auds would typically be ["https://signin.aws.amazon.com/saml"]. | <pre>list(object({<br>    saml_idp_arns : list(string),<br>    saml_auds : list(string)<br>  }))</pre> | `[]` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| role\_arn | IAM role ARN. |
| role\_name | IAM role name. |

<!-- END -->
