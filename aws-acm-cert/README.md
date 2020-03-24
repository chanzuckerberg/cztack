# AWS ACM Cert

Will create and attempt to validate an certificate in the [AWS ACM service](https://aws.amazon.com/certificate-manager/). This module uses DNS verification so the principal running this needs to be able to write to the supplied Route53 zone.

NOTE: if you intend to use this certificate in a cloudfront distribution it must be created in `us-east-1` region.

## Example

```hcl
module "cert" {
  source = "github.com/chanzuckerberg/cztack//aws-acm-cert?ref=v0.14.0"

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
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| allow\_validation\_record\_overwrite | Allow the overwrite of validation records. This is needed if you are creating certificates in multiple regions. | `string` | `true` | no |
| aws\_route53\_zone\_id | n/a | `string` | n/a | yes |
| cert\_domain\_name | Like www.foo.bar.com or *.foo.bar.com | `string` | n/a | yes |
| cert\_subject\_alternative\_names | A map of <alternative\_domain:route53\_zone\_id> | `map` | `{}` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| subject\_alternative\_names\_order | Order to list the subject alternative names in the ACM cert. Workaround for https://github.com/terraform-providers/terraform-provider-aws/issues/8531 | `list(string)` | n/a | yes |
| validation\_record\_ttl | n/a | `string` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| id | n/a |

<!-- END -->
