# AWS ACM Cert

Will create and attempt to validate an certificate in AWS' ACM service. This module uses DNS verification so the principle running this needs to be able to write to the relevant Route53 zone.

NOTE: if you intend to use this certificate in a cloudfront distribution it must exist in us-east-1 region.

## Example

```hcl
module "cert" {
  source = "github.com/chanzuckerberg/cztack//aws-acm-cert?ref=master"

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
| aws_route53_zone_id |  | string | - | yes |
| cert_domain_name | Like www.foo.bar.com or *.foo.bar.com | string | - | yes |
| cert_subject_alternative_names | A map of <alternative_domain:route53_zone_id> | map | `<map>` | no |
| env |  | string | - | yes |
| owner |  | string | - | yes |
| project |  | string | - | yes |
| service |  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| id |  |

<!-- END -->
