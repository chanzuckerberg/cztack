# GitHub Webhooks to S3

This module will configure an aggregator for GitHub webhooks. It sets up an API Gateway with a Lambda that will authenticate incomming webhooks from GitHub and then use Firehose to store these events into S3. This module will configure the necessary IAM Roles, S3 bucket, API Gateway, and Firehose resources.

## Usage
- Create a Webhook you would like to capture in GitHub and point it at your `var.fqdn`.
- API Gateway relies on ACM Certificates in us-east-1
- This module reads secrets from the AWS ParamStore using [chamber](https://github.com/segmentio/chamber).You can write the GitHub validation secret `AWS_PROFILE=<your profile> chamber write <var.project>-<var.env>-<var.service> github_secret <the secret>`

```hcl
module "archiver" {
  // Replace with latest cztack stable release https://github.com/chanzuckerberg/cztack/releases
  source = "github.com/chanzuckerberg/cztack//github-webhooks-to-s3?ref=master"

  env     = "${var.env}"
  project = "${var.project}"
  owner   = "${var.owner}"
  service = "${var.component}"

  fqdn            = "github.foo.bar.com"
  certificate_arn = "..." // This MUST be in us-east-1 region
  route53_zone_id = "..." // Route53 zone to write records to
}

```

<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certificate\_arn | A certificate in us-east-1 for var.fqdn | `string` | n/a | yes |
| env | Env for tagging and naming. | `string` | n/a | yes |
| fqdn | The fqdn to expose the api gateway as | `string` | n/a | yes |
| iam\_path | n/a | `string` | `"/"` | no |
| lambda\_source\_s3\_bucket | The s3 bucket where to find the lambda executable | `string` | `"shared-infra-prod-assets"` | no |
| lambda\_source\_s3\_key | The s3 key where to find the lambda executable | `string` | `"go-misc/lambdas/2019/06/03/github_to_firehose.zip"` | no |
| owner | Owner for tagging and naming. | `string` | n/a | yes |
| project | Project for tagging and naming. | `string` | n/a | yes |
| route53\_zone\_id | The route53 zone id for fqdn's domain | `string` | n/a | yes |
| s3\_prefix | Firehose will add this prefix to files it writes to the s3 bucket | `string` | `""` | no |
| service | Service for tagging and naming. | `string` | n/a | yes |

## Outputs

No output.

<!-- END -->
