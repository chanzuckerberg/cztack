# AWS S3 Single Page Static Site

This module will create a public static site backed by [Cloudfront](https://aws.amazon.com/cloudfront/) and [S3](https://aws.amazon.com/s3/).

A few things this module does for you–

* creates an s3 bucket
  * ensures data is encrypted by default through S3 Server Side Encryption
  * although the bucket is public, we restrict access to a cloudfront [origin access identity](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html)
  identity
* creates a cloudfront distribution
  * TLS required through [ACM](https://aws.amazon.com/certificate-manager/)
  * allows you to configure vanity aliases
  * configures the distribution to serve a single page application
  * configures gzip compression
* configures route53 records for your distribution
* tags all resources with our [consistent tags](../README.md#Consistent%20Tagging)

This module is specifically designed for Single Page Applications– In order to make this work, cloudfront redirects certain S3 http responses (`403`, `404`, `503`) back to your index page for handling.

## Example

```hcl
module "site" {
  source = "github.com/chanzuckerberg/cztack//aws-single-page-static-site?ref=v0.14.0"

  cert_domain_name               = "..."
  cert_subject_alternative_names = "..."
  aws_route53_zone_id            = "..."
  validation_record_ttl          = "..."

  # Variables used for tagging
  env     = "..."
  project = "..."
  service = "..."
  owner   = "..."
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aliases | Vanity aliases. Make sure your provided cert supports these. | list | `<list>` | no |
| aws_acm_cert_arn | An AWS ACM cert. Note that Cloudfront requires certs to be in us-east-1. | string | - | yes |
| aws_route53_zone_id | A route53 zone ID used to write records. | string | - | yes |
| cloudfront_price_class | Cloudfront [price class](https://aws.amazon.com/cloudfront/pricing/). | string | `PriceClass_100` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| index_document_path | The path to the index document of your site. | string | `index.html` | no |
| minimum_tls_version | Minimum TLS version to accept. | string | `TLSv1_2016` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| subdomain | The subdomain for this static site. | string | - | yes |

<!-- END -->
