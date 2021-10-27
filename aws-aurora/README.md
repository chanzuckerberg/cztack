# AWS Aurora Module

This is a low-level module for creating AWS Aurora clusters. We strongly reccomend you use one of the higher-level, opinionated modules for [mysql](../aws-aurora-mysql/README.md) or [postgres](../aws-aurora-postgres/README.md).

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.44.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.44.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_rds_cluster.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | n/a | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Set the databases to automatically upgrade minor versions. | `bool` | `true` | no |
| <a name="input_backtrack_window"></a> [backtrack\_window](#input\_backtrack\_window) | n/a | `number` | `0` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | Identifier for the certificate authority. Use rds-ca-2019 for anything new. | `string` | `"rds-ca-2019"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | n/a | `string` | n/a | yes |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | n/a | `string` | n/a | yes |
| <a name="input_database_subnet_group"></a> [database\_subnet\_group](#input\_database\_subnet\_group) | n/a | `string` | n/a | yes |
| <a name="input_database_username"></a> [database\_username](#input\_database\_username) | n/a | `string` | n/a | yes |
| <a name="input_db_deletion_protection"></a> [db\_deletion\_protection](#input\_db\_deletion\_protection) | n/a | `string` | `false` | no |
| <a name="input_db_parameters"></a> [db\_parameters](#input\_db\_parameters) | n/a | `list(any)` | `[]` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | n/a | `list(any)` | `[]` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | n/a | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | n/a | `string` | `true` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | A list of CIDR blocks that should be allowed to communicate with this Aurora cluster. | `list(string)` | `[]` | no |
| <a name="input_ingress_security_groups"></a> [ingress\_security\_groups](#input\_ingress\_security\_groups) | A list of security groups that should be allowed to communicate with this Aurora cluster. | `list(string)` | `[]` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | n/a | `string` | `"db.t2.small"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | n/a | `string` | `1` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | If supplied, RDS will use this key to encrypt data at rest. Empty string means that RDS will use an AWS-managed key. Encryption is always on with this module. | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_params_engine_version"></a> [params\_engine\_version](#input\_params\_engine\_version) | n/a | `string` | n/a | yes |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | n/a | `string` | `true` | no |
| <a name="input_port"></a> [port](#input\_port) | n/a | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | n/a | `bool` | `false` | no |
| <a name="input_rds_cluster_parameters"></a> [rds\_cluster\_parameters](#input\_rds\_cluster\_parameters) | n/a | `list(any)` | `[]` | no |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | n/a |
| <a name="output_db_parameter_group_name"></a> [db\_parameter\_group\_name](#output\_db\_parameter\_group\_name) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_port"></a> [port](#output\_port) | n/a |
| <a name="output_rds_cluster_id"></a> [rds\_cluster\_id](#output\_rds\_cluster\_id) | n/a |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | n/a |
<!-- END -->
