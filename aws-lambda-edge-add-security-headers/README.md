# aws-lambda-edge-add-security-headers

This module creates a Lambda@Edge that, when setup as an `origin-response` function on Cloudfront, adds security headers to all responses.

This must be used with a `viewer_protocol_policy` of `redirect-to-https`, otherwise it will add out of spec headers to insecure HTTP only requests.

## Warning - Cannot be automatically deleted

Lambda@Edge functions are [hard to delete automatically](https://docs.aws.amazon.com/lambda/latest/dg/lambda-edge.html) and there is no terraform-specific work-around to deal with that.

## Example

```hcl
resource aws_cloudfront_distribution cf {
  enabled = true

  origin {
    domain_name = aws_s3_bucket.redirect_bucket.website_endpoint
    origin_id   = "s3_www_redirect"
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"

    target_origin_id = "s3_www_redirect"

    lambda_function_association {
      event_type   = "origin-response"
      include_body = false
      lambda_arn   = module.security_headers_lambda.qualified_arn
    }
  }
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | ~> 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ../aws-lambda-function |  |

## Resources

| Name | Type |
|------|------|
| [archive_file.lambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | The name for the lambda function. | `string` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | The qualified arn (version number included) of the latest published lambda version. |
<!-- END -->
