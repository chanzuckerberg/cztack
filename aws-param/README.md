# AWS ParamStore Secret (DEPRECATED)

__*Deprecated. Please use `aws-ssm-params` module for new code*__

This module is made to work together with [Chamber](https://github.com/segmentio/chamber) to manage secrets in AWS. Typically a user would use chamber to put secrets into the ParamStore and then use this module to read them out in Terraform code.

You can use [our secrets setup module](../aws-param-secrets-setup/README.md) to prepare an AWS account/region to work with these tools.

## Example

```hcl
module "secret" {
  source = "github.com/chanzuckerberg/cztack/aws-param-secret?ref=v0.14.0"

  project = "acme"
  env     = "staging"
  service = "website"

  name = "password"
}

# yeah don't really do this
output "secret" {
  value = "${module.secret.value}"
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
| name | The name of the secret. | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| use\_paths | This exists to support data written by Chamber before version 2.0.0, which used '.' instead of '/' as a separator. | `string` | `"true"` | no |

## Outputs

| Name | Description |
|------|-------------|
| value | n/a |

<!-- END -->
