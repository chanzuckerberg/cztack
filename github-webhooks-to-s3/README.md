<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| certificate\_arn | A certificate in us-east-1 for var.fqdn | string | n/a | yes |
| env | Env for tagging and naming. | string | n/a | yes |
| fqdn | The fqdn to expose the api gateway as | string | n/a | yes |
| iam\_path |  | string | `"/"` | no |
| lambda\_source\_s3\_bucket | The s3 bucket where to find the lambda executable | string | `"shared-infra-prod-assets"` | no |
| lambda\_source\_s3\_key | The s3 key where to find the lambda executable | string | `"go-misc/lambdas/2019/06/03/github_to_firehose.zip"` | no |
| owner | Owner for tagging and naming. | string | n/a | yes |
| project | Project for tagging and naming. | string | n/a | yes |
| route53\_zone\_id | The route53 zone id for fqdn's domain | string | n/a | yes |
| service | Service for tagging and naming. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| fivetran\_role\_arn |  |

<!-- END -->