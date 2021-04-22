# aws-cloudfront-domain-redirect

This module uses cloudfront to redirect from the `source_domain` to the `target_domain`. The most common use case for this is to redirect a naked domain, eg `http://foo.com`, to something else like `https://www.foo.com`.

The redirect has the following properties:

- Always redirects http:// to https://
- Add HSTS + preload headers to the https:// response.

## Warning - Cannot be automatically deleted

Lambda@Edge functions are [hard to delete automatically](https://docs.aws.amazon.com/lambda/latest/dg/lambda-edge.html) and there is no terraform-specific work-around to deal with that.

## Example

```hcl
module domain-redirect {
  source = "git@github.com:chanzuckerberg/cztack//aws-cloudfront-domain-redirect"

  source_domain = "example.org"
  target_domain = "www.example.org"
  source_domain_zone_id = data.terraform_remote_state.example-org.outputs.zone_ids["example.org"]

  owner   = var.owner
  project = var.project
  service = var.component
  env     = var.env
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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert"></a> [cert](#module\_cert) | ../aws-acm-cert |  |
| <a name="module_security_headers_lambda"></a> [security\_headers\_lambda](#module\_security\_headers\_lambda) | ../aws-lambda-edge-add-security-headers |  |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.cf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_route53_record.alias_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.alias_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.redirect_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_source_domain"></a> [source\_domain](#input\_source\_domain) | The domain that will be redirected from. | `string` | n/a | yes |
| <a name="input_source_domain_zone_id"></a> [source\_domain\_zone\_id](#input\_source\_domain\_zone\_id) | Route53 zone id for the source domain. | `string` | n/a | yes |
| <a name="input_target_domain"></a> [target\_domain](#input\_target\_domain) | The domain that will be redirected to. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END -->
