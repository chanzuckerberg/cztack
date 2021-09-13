# AWS ACM Certificate

Will create and attempt to validate an certificate in the [AWS ACM service](https://aws.amazon.com/certificate-manager/). This module uses DNS verification so the principal running this needs to be able to write to the supplied Route53 zone.

NOTE: if you intend to use this certificate in a cloudfront distribution it must be created in `us-east-1` region.

## Example

```hcl
module "cert" {
  source = "github.com/chanzuckerberg/cztack//aws-acm-certificate?ref=v0.40.0"

  # the cert domain name
  cert_domain_name = "..."

  # the route53 zone for validating the `cert_domain_name`
  aws_route53_zone_id = "..."

  # an optional map of alternative : route53_zone_id
  cert_subject_alternative_names = {"foobar.com" = data.aws_route53_zone.foo.id}

  # optional variable for tags
  tags = {
    project = "...",
    env     = "...",
    service = "...",
    owner   = "..."
  }
}
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| aws | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_route53\_zone\_id | Default Route 53 zone to create validation records in | `string` | n/a | yes |
| cert\_domain\_name | Like www.foo.bar.com or \*.foo.bar.com | `string` | n/a | yes |
| cert\_subject\_alternative\_names | A map of <alternative\_domain:route53\_zone\_id> | `map(string)` | `{}` | no |
| tags | Tags to apply to certificate | `object({ project : string, env : string, service : string, owner : string, managedBy : string })` | n/a | yes |
| validation\_record\_ttl | TTL value of DNS validation records | `string` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | AWS ARN of the certificate |
| id | ID of the certificate |

<!-- END -->
