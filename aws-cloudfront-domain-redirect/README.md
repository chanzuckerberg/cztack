# aws-cloudfront-domain-redirect

This module uses cloudfront to redirect from the `source_domain` to the `target_domain`. The most common use case for this is to redirect a naked domain, eg `http://foo.com`, to something else like `https://www.foo.com`.

The redirect has the following properties:
- Always redirects http:// to https://
- Add HSTS + preload headers to the https:// response.

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
| aws | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| source\_domain | The domain that will be redirected from. | `string` | n/a | yes |
| source\_domain\_zone\_id | Route53 zone id for the source domain. | `string` | n/a | yes |
| target\_domain | The domain that will be redirected to. | `string` | n/a | yes |

## Outputs

No output.

<!-- END -->
