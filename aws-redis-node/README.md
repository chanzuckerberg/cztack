# Redis Node

This module creates a single-node Elasticache Redis cluster with the given
parameters.

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
| apply\_immediately | Whether changes should be applied immediately or during the next maintenance window. | `bool` | `true` | no |
| availability\_zone | Availability zone in which this instance should run. | `string` | `null` | no |
| engine\_version | The version of Redis to run. See [supported versions](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/supported-engine-versions.html) | `string` | `"5.0.5"` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| ingress\_security\_group\_ids | Source security groups which should be able to contact this instance. | `list(string)` | n/a | yes |
| instance\_type | The type of instance to run. See [supported node types](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html) | `string` | `"cache.m5.large"` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| parameter\_group\_name | Parameter group to use for this Redis cache. | `string` | `"default.redis5.0"` | no |
| port | Port to host Redis on. | `number` | `6379` | no |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| resource\_name | If not set, name will be [var.project]-[var.env]-[var.name]. | `string` | `""` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | `"redis"` | no |
| subnets | List of subnets to which this EC instance should be attached. They should probably be private. | `list(string)` | n/a | yes |
| vpc\_id | VPC where the cache will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| address | n/a |
| port | n/a |

<!-- END -->
