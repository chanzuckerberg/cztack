# AWS Aurora Module

This is a low-level module for creating AWS Aurora clusters. We strongly reccomend you use one of the higher-level, opinionated modules for [mysql](../aws-aurora-mysql/README.md) or [postgres](../aws-aurora-postgres/README.md).

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| aws | >= 2.44.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.44.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apply\_immediately | n/a | `bool` | `false` | no |
| auto\_minor\_version\_upgrade | Set the databases to automatically upgrade minor versions. | `bool` | `true` | no |
| backtrack\_window | n/a | `number` | `0` | no |
| ca\_cert\_identifier | Identifier for the certificate authority. Use rds-ca-2019 for anything new. | `string` | `"rds-ca-2019"` | no |
| database\_name | n/a | `string` | n/a | yes |
| database\_password | n/a | `string` | n/a | yes |
| database\_subnet\_group | n/a | `string` | n/a | yes |
| database\_username | n/a | `string` | n/a | yes |
| db\_deletion\_protection | n/a | `string` | `false` | no |
| db\_parameters | n/a | `list` | `[]` | no |
| enabled\_cloudwatch\_logs\_exports | n/a | `list` | `[]` | no |
| engine | n/a | `string` | n/a | yes |
| engine\_version | n/a | `string` | n/a | yes |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| iam\_database\_authentication\_enabled | n/a | `string` | `true` | no |
| ingress\_cidr\_blocks | A list of CIDR blocks that should be allowed to communicate with this Aurora cluster. | `list(string)` | `[]` | no |
| ingress\_security\_groups | A list of security groups that should be allowed to communicate with this Aurora cluster. | `list(string)` | `[]` | no |
| instance\_class | n/a | `string` | `"db.t2.small"` | no |
| instance\_count | n/a | `string` | `1` | no |
| kms\_key\_id | If supplied, RDS will use this key to encrypt data at rest. Empty string means that RDS will use an AWS-managed key. Encryption is always on with this module. | `string` | `""` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| params\_engine\_version | n/a | `string` | n/a | yes |
| performance\_insights\_enabled | n/a | `string` | `true` | no |
| port | n/a | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| publicly\_accessible | n/a | `bool` | `false` | no |
| rds\_cluster\_parameters | n/a | `list` | `[]` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| skip\_final\_snapshot | n/a | `bool` | `false` | no |
| vpc\_id | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_name | n/a |
| db\_parameter\_group\_name | n/a |
| endpoint | n/a |
| port | n/a |
| rds\_cluster\_id | n/a |
| reader\_endpoint | n/a |

<!-- END -->
