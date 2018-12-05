# AWS Aurora Module

This is a low-level module for creating AWS Aurora clusters. We strongly reccomend you use one of the higher-level, opinionated modules for [mysql](../aws-aurora-mysql/README.md) or [postgres](../aws-aurora-postgres/README.md).

<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apply\_immediately | - | string | `false` | no |
| backtrack\_window | - | string | `0` | no |
| database\_name | - | string | - | yes |
| database\_password | - | string | - | yes |
| database\_subnet\_group | - | string | - | yes |
| database\_username | - | string | - | yes |
| db\_parameters | - | list | `<list>` | no |
| enabled\_cloudwatch\_logs\_exports | - | list | `<list>` | no |
| engine | - | string | - | yes |
| engine\_version | - | string | - | yes |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| iam\_database\_authentication\_enabled | - | string | `true` | no |
| ingress\_cidr\_blocks | - | list | - | yes |
| instance\_class | - | string | `db.t2.small` | no |
| instance\_count | - | string | `1` | no |
| kms\_key\_id | If supplied, RDS will use this key to encrypt data at rest. Empty string means that RDS will use an AWS-managed key. Encryption is always on with this module. | string | `` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| performance\_insights\_enabled | - | string | `true` | no |
| port | - | string | - | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| publicly\_accessible | - | string | `false` | no |
| rds\_cluster\_parameters | - | list | `<list>` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| skip\_final\_snapshot | - | string | `false` | no |
| vpc\_id | - | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_name | - |
| endpoint | - |
| port | - |
| reader\_endpoint | - |

<!-- END -->
