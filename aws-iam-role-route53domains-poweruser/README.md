# AWS IAM role for Route53Domains Poweruser

This module will create a role which has Route53Domains FullAccess privileges and Route53 ReadOnly priveleges.

## Example

```hcl
module "route53domains-poweruser" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-role-route53domains-poweruser?ref=v0.14.0"

  # The name of the role to create in this account.
  role_name = "..."

  # The ID of the other AWS account which can assume this role.
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
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| iam\_path | n/a | `string` | `"/"` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| role\_name | n/a | `string` | `"route53domains-poweruser"` | no |
| saml\_idp\_arns | The AWS SAML IDP arns to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| source\_account\_ids | The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |

<!-- END -->
