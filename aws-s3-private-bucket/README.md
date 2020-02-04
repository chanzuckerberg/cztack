<!-- START -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| abort\_incomplete\_multipart\_upload\_days | Number of days after which an incomplete multipart upload is canceled. | `number` | `14` | no |
| bucket\_name | n/a | `string` | n/a | yes |
| bucket\_policy | n/a | `string` | `""` | no |
| enable\_versioning | Keep old versions of overwritten S3 objects. | `bool` | `true` | no |
| env | n/a | `string` | n/a | yes |
| owner | n/a | `string` | n/a | yes |
| project | n/a | `string` | n/a | yes |
| service | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| domain\_name | n/a |
| id | n/a |
| name | HACK(el): we do this to hint TF dependency graph since modules can't depend\_on |

<!-- END -->
