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
| bucket\_contents | Sentence that describes the data inside this bucket | `string` | n/a | yes |
| bucket\_name | The name of the bucket. | `string` | n/a | yes |
| bucket\_policy | A policy to attach to this bucket. | `string` | `""` | no |
| env | Env for tagging and naming. | `string` | n/a | yes |
| owner | Owner for tagging and naming. | `string` | n/a | yes |
| project | Project for tagging and naming. | `string` | n/a | yes |
| public\_reason | Sentence that describes why the bucket is public-read | `string` | n/a | yes |
| service | Service for tagging and naming. | `string` | n/a | yes |

## Outputs

No output.

<!-- END -->
