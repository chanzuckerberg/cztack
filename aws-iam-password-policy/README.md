# AWS IAM Password Policy

This module is useful for setting a password policy on AWS IAM.

## Example

```hcl
module "password-policy" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-password-policy?ref=v0.14.0"
}
```

<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_account_password_policy.strict](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END -->
