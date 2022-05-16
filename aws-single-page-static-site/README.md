# AWS S3 Single Page Static Site

This module will create a public static site powered by [S3](https://aws.amazon.com/s3/) with [Cloudfront](https://aws.amazon.com/cloudfront/) in front.

A few things this module does for you–

* creates a private s3 bucket
  * ensures data is encrypted by default using S3 Server Side Encryption
  * restricts access to a cloudfront [origin access identity](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html)
  identity
* creates a cloudfront distribution
  * TLS required through [ACM](https://aws.amazon.com/certificate-manager/)
  * allows you to configure multiple aliases
  * configures the distribution to serve a single page application
  * configures gzip compression
* configures route53 records for your distribution
* tags all resources with our [consistent tags](../README.md#Consistent%20Tagging)

This module is specifically designed for Single Page Applications– In order to make this work, cloudfront redirects certain S3 http responses (`403`, `404`, `503`) back to your index page for handling.

## Example

```hcl
module "site" {
  source = "github.com/chanzuckerberg/cztack//aws-single-page-static-site?ref=v0.40.0"

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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_security_headers_lambda"></a> [security\_headers\_lambda](#module\_security\_headers\_lambda) | ../aws-lambda-edge-add-security-headers | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.origin_access_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_route53_record.ipv4-record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.ipv6-record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.www-ipv4-record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.www-ipv6-record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aliases"></a> [aliases](#input\_aliases) | Vanity aliases. Make sure your provided cert supports these. | `list(any)` | `[]` | no |
| <a name="input_aws_acm_cert_arn"></a> [aws\_acm\_cert\_arn](#input\_aws\_acm\_cert\_arn) | An AWS ACM cert. Note that Cloudfront requires certs to be in us-east-1. | `string` | n/a | yes |
| <a name="input_aws_route53_zone_id"></a> [aws\_route53\_zone\_id](#input\_aws\_route53\_zone\_id) | A route53 zone ID used to write records. | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the bucket to created. If not given, it will use the domain name. | `string` | `""` | no |
| <a name="input_cloudfront_price_class"></a> [cloudfront\_price\_class](#input\_cloudfront\_price\_class) | Cloudfront [price class](https://aws.amazon.com/cloudfront/pricing/). | `string` | `"PriceClass_100"` | no |
| <a name="input_custom_error_response_codes"></a> [custom\_error\_response\_codes](#input\_custom\_error\_response\_codes) | The http response codes for which to return the default index page. Defaults to [404, 403, 503] | `list(number)` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_index_document_path"></a> [index\_document\_path](#input\_index\_document\_path) | The path to the index document of your site. | `string` | `"index.html"` | no |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | Minimum TLS version to accept. | `string` | `"TLSv1.1_2016"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_path_pattern"></a> [path\_pattern](#input\_path\_pattern) | The pattern (for example, images/*.jpg) that specifies which requests you want this cache behavior to apply to. | `string` | `"*"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The subdomain for this static site. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | n/a |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | n/a |
| <a name="output_cloudfront_arn"></a> [cloudfront\_arn](#output\_cloudfront\_arn) | n/a |
| <a name="output_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#output\_cloudfront\_domain\_name) | n/a |
| <a name="output_cloudfront_hosted_zone_id"></a> [cloudfront\_hosted\_zone\_id](#output\_cloudfront\_hosted\_zone\_id) | n/a |
<!-- END -->
