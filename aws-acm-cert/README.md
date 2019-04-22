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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_route53\_zone\_id |  | string | n/a | yes |
| cert\_domain\_name | Like www.foo.bar.com or *.foo.bar.com | string | n/a | yes |
| cert\_subject\_alternative\_names | A map of <alternative_domain:route53_zone_id> | map | `<map>` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | string | n/a | yes |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | string | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | string | n/a | yes |
| validation\_record\_ttl |  | string | `"60"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| id |  |

<!-- END -->
