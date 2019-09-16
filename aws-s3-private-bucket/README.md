<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket\_name |  | string | n/a | yes |
| bucket\_policy |  | string | `""` | no |
| enable\_versioning | Keep old versions of overwritten S3 objects. | bool | `true` | no |
| env |  | string | n/a | yes |
| owner |  | string | n/a | yes |
| project |  | string | n/a | yes |
| service |  | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| domain\_name |  |
| id |  |
| name | We do this to hint TF dependency graph since modules can't depend_on |

<!-- END -->
