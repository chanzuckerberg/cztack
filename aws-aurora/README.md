# AWS Aurora Module

This is a low-level module for creating AWS Aurora clusters. We strongly reccomend you use one of the higher-level, opinionated modules for [mysql](../aws-aurora-mysql/README.md) or [postgres](../aws-aurora-postgres/README.md).

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apply_immediately |  | string | `false` | no |
| backtrack_window |  | string | `0` | no |
| database_name |  | string | - | yes |
| database_password |  | string | - | yes |
| database_subnet_group |  | string | - | yes |
| database_username |  | string | - | yes |
| db_parameters |  | list | `<list>` | no |
| engine |  | string | - | yes |
| env |  | string | - | yes |
| ingress_cidr_blocks |  | list | - | yes |
| instance_class |  | string | `db.t2.small` | no |
| instance_count |  | string | `1` | no |
| kms_key_id | If supplied, RDS will use this key to encrypt data at rest. Empty string means that RDS will use an AWS-managed key. Encryption is always on with this module. | string | `` | no |
| owner |  | string | - | yes |
| port |  | string | - | yes |
| project |  | string | - | yes |
| publicly_accessible |  | string | `false` | no |
| rds_cluster_parameters |  | list | `<list>` | no |
| service |  | string | - | yes |
| skip_final_snapshot |  | string | `false` | no |
| vpc_id |  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| database_name |  |
| endpoint |  |
| port |  |

<!-- END -->
