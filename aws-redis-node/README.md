# Redis Node

This module creates a single-node Elasticache Redis cluster with the given
parameters.

<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apply\_immediately | Whether changes should be applied immediately or during the next maintenance window. | string | `"true"` | no |
| availability\_zone | Availability zone in which this instance should run. | string | n/a | yes |
| engine\_version | The version of Redis to run. See [supported versions](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/supported-engine-versions.html) | string | `"4.0.10"` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | string | n/a | yes |
| ingress\_security\_group\_ids | Source security groups which should be able to contact this instance. | list | n/a | yes |
| instance\_type | The type of instance to run. See [supported node types](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html) | string | `"cache.m4.large"` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | string | n/a | yes |
| parameter\_group\_name |  | string | `"default.redis3.2"` | no |
| port |  | string | `"6379"` | no |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | n/a | yes |
| resource\_name | If not set, name will be [var.project]-[var.env]-[var.name]. | string | `""` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | string | `"redis"` | no |
| subnets | List of subnets to which this EC instance should be attached. They should probably be private. | list | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| address |  |
| port |  |

<!-- END -->
