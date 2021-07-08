# AWS SSM Params Reader

This module is made to work together with [Chamber](https://github.com/segmentio/chamber) to manage secrets in AWS. Typically a user would use chamber to put secrets into the ParamStore and then use this module to read them out in Terraform code.

You can use [our secrets setup module](../aws-params-secrets-setup/README.md) to prepare an AWS account/region to work with these tools.

## Example

```hcl
module "secret" {
  source = "github.com/chanzuckerberg/cztack//aws-ssm-params?ref=v0.40.0"

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
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Set of names of secrets. | `set(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_values"></a> [values](#output\_values) | Map from keys to corresponding values stored in the SSM Parameter Store. |
<!-- END -->
