# Redis Node

This module creates a single-node Elasticache Redis cluster with the given
parameters.

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apply_immediately |  | string | `true` | no |
| availability_zone |  | string | - | yes |
| engine_version |  | string | `4.0.10` | no |
| env |  | string | - | yes |
| ingress_security_group_ids |  | list | - | yes |
| instance_type |  | string | `cache.m4.large` | no |
| owner |  | string | - | yes |
| parameter_group_name |  | string | `default.redis3.2` | no |
| port |  | string | `6379` | no |
| project | Project for tags. See [../README.md#consistent-tagging] | string | - | yes |
| resource_name | If not set, name will be ${var.project}-${var.env}-${var.name}. | string | `` | no |
| service |  | string | `redis` | no |
| subnets |  | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| address |  |
| port |  |

<!-- END -->
