<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| database_name |  | string | - | yes |
| database_password |  | string | - | yes |
| database_subnet_group |  | string | - | yes |
| database_username |  | string | - | yes |
| db_parameters |  | list | `<list>` | no |
| env |  | string | - | yes |
| ingress_cidr_blocks |  | list | - | yes |
| instance_class |  | string | - | yes |
| instance_count |  | string | - | yes |
| owner |  | string | - | yes |
| project |  | string | - | yes |
| rds_cluster_parameters |  | list | `<list>` | no |
| service |  | string | - | yes |
| vpc_id |  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| database_name |  |
| endpoint |  |

<!-- END -->
