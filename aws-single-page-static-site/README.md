# AWS S3 Single Page Static Site

This module will create a public static site backed by [Cloudfront](https://aws.amazon.com/cloudfront/) and [S3](https://aws.amazon.com/s3/).

A few things this module does for you–

* creates a private s3 bucket
  * ensures data is encrypted by default through S3 Server Side Encryption
  * grants cloudfront access to this bucket through an origin access
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

<!-- END -->
