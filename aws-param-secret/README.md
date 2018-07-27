# AWS ParamStore Secret

This module is made to work together with [Chamber](https://github.com/segmentio/chamber) to manage secrets in AWS. Typically a user would use chamber to put secrets into the ParamStore and then use this module to read them out in Terraform code.

You can use [our secrets setup module](../aws-param-secrets-setup/README.md) to prepare an AWS account/region to work with these tools.

## Example

```hcl
module "secret" {
  source = "github.com/chanzuckerberg/cztack/aws-param-secret?ref=master" # TODO fix

  project = "acme"
  env     = "staging"
  service = "website"

  name = "password"
}

// yeah don't really do this
output "secret" {
  value = "${module.secret.value}"
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| env | The cloud env (ie staging, prod). | string | - | yes |
| name | The name of the secret. | string | - | yes |
| project | The project name (probably same as team). | string | - | yes |
| service | The service. | string | - | yes |
| use_paths | This exists to support data written by Chamber before version 2.0.0, which used '.' instead of '/' as a separator. | string | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| value |  |

<!-- END -->
