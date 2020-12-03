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
| allow\_public\_list | Allow public to list bucket contents. | `bool` | `false` | no |
| bucket\_contents | Describe the data within this bucket. | `string` | n/a | yes |
| bucket\_name | The name of the bucket. | `string` | n/a | yes |
| bucket\_policy | A policy to attach to this bucket. | `string` | `""` | no |
| env | Env for tagging and naming. | `string` | n/a | yes |
| owner | Owner for tagging and naming. | `string` | n/a | yes |
| project | Project for tagging and naming. | `string` | n/a | yes |
| public\_read\_justification | Describe why this bucket must be public and what it is being used for. | `string` | n/a | yes |
| service | Service for tagging and naming. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | Public bucket ARN |
| domain\_name | Domain where you host the public bucket |
| id | Public Bucket ID |
| name | Name of this public bucket. It should have `public` in its name |

<!-- END -->
