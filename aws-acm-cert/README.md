# AWS ACM Cert

**_DEPRECATED: Use aws-acm-certificate if using Terraform AWS Provider >3.0._**

Will create and attempt to validate an certificate in the [AWS ACM service](https://aws.amazon.com/certificate-manager/). This module uses DNS verification so the principal running this needs to be able to write to the supplied Route53 zone.

NOTE: if you intend to use this certificate in a cloudfront distribution it must be created in `us-east-1` region.

## Example

```hcl
module "cert" {
  source = "github.com/chanzuckerberg/cztack//aws-acm-cert?ref=v0.36.0"

  # the cert domain name
  cert_domain_name = "..."
  
  # the route53 zone for validating the `cert_domain_name`
  aws_route53_zone_id = "..."
  
  # a map of alternative : route53_zone_id 
  cert_subject_alternative_names = "${map(..)}"


  # variables for tags
  owner   = "..."
  project = "..."
  env     = "..."
  service = "..."
}
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | < 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_validation_record_overwrite"></a> [allow\_validation\_record\_overwrite](#input\_allow\_validation\_record\_overwrite) | Allow the overwrite of validation records. This is needed if you are creating certificates in multiple regions. | `string` | `true` | no |
| <a name="input_aws_route53_zone_id"></a> [aws\_route53\_zone\_id](#input\_aws\_route53\_zone\_id) | n/a | `string` | n/a | yes |
| <a name="input_cert_domain_name"></a> [cert\_domain\_name](#input\_cert\_domain\_name) | Like www.foo.bar.com or *.foo.bar.com | `string` | n/a | yes |
| <a name="input_cert_subject_alternative_names"></a> [cert\_subject\_alternative\_names](#input\_cert\_subject\_alternative\_names) | A map of <alternative\_domain:route53\_zone\_id> | `map(string)` | `{}` | no |
| <a name="input_cert_subject_alternative_names_count"></a> [cert\_subject\_alternative\_names\_count](#input\_cert\_subject\_alternative\_names\_count) | The size of var.cert\_subject\_alternative\_names. Since var.cert\_subject\_alternative\_names can have dynamic keys/values we must hint terraform on its size. If you have no SANs then this should be 0. | `number` | `0` | no |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_subject_alternative_names_order"></a> [subject\_alternative\_names\_order](#input\_subject\_alternative\_names\_order) | Order to list the subject alternative names in the ACM cert. Workaround for https://github.com/terraform-providers/terraform-provider-aws/issues/8531 | `list(string)` | `null` | no |
| <a name="input_validation_record_ttl"></a> [validation\_record\_ttl](#input\_validation\_record\_ttl) | n/a | `string` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END -->
