# AWS SSM Params Reader

This module is made to work together with [Chamber](https://github.com/segmentio/chamber) to manage secrets in AWS. Typically a user would use chamber to put secrets into the ParamStore and then use this module to read them out in Terraform code.

You can use [our secrets setup module](../aws-params-secrets-setup/README.md) to prepare an AWS account/region to work with these tools.

## Example

```hcl
module "secret" {
  source = "github.com/chanzuckerberg/cztack/aws-ssm-params-secret?ref=v0.18.2"

  project = "acme"
  env     = "staging"
  service = "website"

  parameters = ["password"]
}

# yeah don't really do this
output "secret" {
  value = module.secret.values
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
| parameters | Set of names of secrets. | `set(string)` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| values | Map from keys to corresponding values stored in the SSM Parameter Store. |

<!-- END -->
