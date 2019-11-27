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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam\_path |  | string | `"/"` | no |
| role\_name |  | string | `"route53domains-poweruser"` | no |
| source\_account\_id | The source AWS account to establish a trust relationship. Ignored if empty or not provided. | string | '' | no |
| saml\_idp\_arn | The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided. | string | '' | no |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |

<!-- END -->
