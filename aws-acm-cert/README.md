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
| aws | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_validation\_record\_overwrite | Allow the overwrite of validation records. This is needed if you are creating certificates in multiple regions. | `string` | `true` | no |
| aws\_route53\_zone\_id | n/a | `string` | n/a | yes |
| cert\_domain\_name | Like www.foo.bar.com or \*.foo.bar.com | `string` | n/a | yes |
| cert\_subject\_alternative\_names | A map of <alternative\_domain:route53\_zone\_id> | `map(string)` | `{}` | no |
| cert\_subject\_alternative\_names\_count | The size of var.cert\_subject\_alternative\_names. Since var.cert\_subject\_alternative\_names can have dynamic keys/values we must hint terraform on its size. If you have no SANs then this should be 0. | `number` | `0` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| subject\_alternative\_names\_order | Order to list the subject alternative names in the ACM cert. Workaround for https://github.com/terraform-providers/terraform-provider-aws/issues/8531 | `list(string)` | `null` | no |
| validation\_record\_ttl | n/a | `string` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| id | n/a |

<!-- END -->
