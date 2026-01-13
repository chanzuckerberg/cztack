# AWS ACM Certificate

Will create and attempt to validate an certificate in the [AWS ACM service](https://aws.amazon.com/certificate-manager/). This module uses DNS verification so the principal running this needs to be able to write to the supplied Route53 zone.

NOTE: if you intend to use this certificate in a cloudfront distribution it must be created in `us-east-1` region.

## Example

```hcl
module "cert" {
  source = "github.com/chanzuckerberg/cztack//aws-acm-certificate?ref=v0.40.0"

  # the cert domain name
  cert_domain_name = "..."

  # the route53 zone for validating the `cert_domain_name`
  aws_route53_zone_id = "..."

  # an optional map of alternative : route53_zone_id
  cert_subject_alternative_names = {"foobar.com" = data.aws_route53_zone.foo.id}

  # optional variable for tags
  tags = {
    project = "...",
    env     = "...",
    service = "...",
    owner   = "..."
  }
}
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0.0 |

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
| <a name="input_aws_route53_zone_id"></a> [aws\_route53\_zone\_id](#input\_aws\_route53\_zone\_id) | Default Route 53 zone to create validation records in | `string` | n/a | yes |
| <a name="input_cert_domain_name"></a> [cert\_domain\_name](#input\_cert\_domain\_name) | Like www.foo.bar.com or *.foo.bar.com | `string` | n/a | yes |
| <a name="input_cert_subject_alternative_names"></a> [cert\_subject\_alternative\_names](#input\_cert\_subject\_alternative\_names) | A map of <alternative\_domain:route53\_zone\_id> | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to certificate | `object({ project : string, env : string, service : string, owner : string, managedBy : string })` | n/a | yes |
| <a name="input_validation_record_ttl"></a> [validation\_record\_ttl](#input\_validation\_record\_ttl) | TTL value of DNS validation records | `string` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | AWS ARN of the certificate |
| <a name="output_id"></a> [id](#output\_id) | ID of the certificate |
<!-- END -->
