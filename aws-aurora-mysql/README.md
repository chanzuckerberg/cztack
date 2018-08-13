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
| env |  | string | - | yes |
| ingress_cidr_blocks |  | list | - | yes |
| instance_class |  | string | `db.t2.small` | no |
| instance_count |  | string | - | yes |
| kms_key_id |  | string | `` | no |
| owner |  | string | - | yes |
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

<!-- END -->
