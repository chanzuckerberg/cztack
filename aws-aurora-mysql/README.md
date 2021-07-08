# AWS Aurora MySQL

This module will create a robust and secure [AWS Aurora](https://aws.amazon.com/rds/aurora/) MySQL cluster.

A few things this module does for you–

* ensures that data is encrypted at rest, either via an AWS managed key or if you supply `kms_key_id` a key that you control (via KMS).
* tags all resources with our [consistent tags](../README.md#Consistent%20Tagging)
* sets some sane defaults for database and cluster parameters

A simple example:

```hcl
module "db" {
  source = "github.com/chanzuckerberg/cztack//aws-aurora-mysql?ref=v0.36.0"

  database_name         = "..."
  database_subnet_group = "..."
  database_password     = "..."
  database_password     = "..."

  vpc_id               = "..."
  ingress_cidr_blocks	 = "..."

  # Variables used for tagging
  env     = "..."
  project = "..."
  service = "..."
  owner   = "..."
}
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.44.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | ../aws-aurora | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | If false changes will not be applied until next maintenance window. | `string` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Set the databases to automatically upgrade minor versions. | `bool` | `true` | no |
| <a name="input_backtrack_window"></a> [backtrack\_window](#input\_backtrack\_window) | Turns on Backgrack for this many seconds. [Doc](https://aws.amazon.com/blogs/aws/amazon-aurora-backtrack-turn-back-time/) | `string` | `0` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | Identifier for the certificate authority. rds-ca-2019 is the latest available version. | `string` | `"rds-ca-2019"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the database to be created in the cluster. | `string` | n/a | yes |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | Password for user that will be created. | `string` | n/a | yes |
| <a name="input_database_subnet_group"></a> [database\_subnet\_group](#input\_database\_subnet\_group) | The name of an existing database subnet group to use. | `string` | n/a | yes |
| <a name="input_database_username"></a> [database\_username](#input\_database\_username) | Default user to be created. | `string` | n/a | yes |
| <a name="input_db_deletion_protection"></a> [db\_deletion\_protection](#input\_db\_deletion\_protection) | n/a | `string` | `false` | no |
| <a name="input_db_parameters"></a> [db\_parameters](#input\_db\_parameters) | Instance params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Reference.html#AuroraMySQL.Reference.Parameters.Instance) | `list(any)` | <pre>[<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "general_log",<br>    "value": 1<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "slow_query_log",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "long_query_time",<br>    "value": "0"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "log_output",<br>    "value": "file"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "log_queries_not_using_indexes",<br>    "value": "1"<br>  }<br>]</pre> | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the engine to be used for aurora-mysql. | `string` | `"5.7"` | no |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | n/a | `string` | `false` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | A list of CIDR blocks that should be allowed to communicate with this Aurora cluster. | `list(string)` | `[]` | no |
| <a name="input_ingress_security_groups"></a> [ingress\_security\_groups](#input\_ingress\_security\_groups) | A list of security groups that should be allowed to communicate with this Aurora cluster. | `list(string)` | `[]` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | See valid instance types [here](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Managing.Performance.html) | `string` | `"db.t2.small"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances to create in this cluster. | `string` | `1` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | If provided, storage will be encrypted with this key, otherwise an AWS-managed key is used. (Encryption is always on). | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_params_engine_version"></a> [params\_engine\_version](#input\_params\_engine\_version) | The engine version to be appended to the parameter group family. | `string` | `"5.7"` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | n/a | `string` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Avoid doing this - it gives access to the open internet. | `string` | `false` | no |
| <a name="input_rds_cluster_parameters"></a> [rds\_cluster\_parameters](#input\_rds\_cluster\_parameters) | Cluster params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Reference.html#AuroraMySQL.Reference.Parameters.Cluster) | `list(any)` | <pre>[<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "character_set_server",<br>    "value": "utf8"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "character_set_client",<br>    "value": "utf8"<br>  }<br>]</pre> | no |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | When you destroy a database RDS will, by default, take snapshot. Set this to skip that step. | `string` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of the existing VPC in which this cluster should be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | n/a |
| <a name="output_db_parameter_group_name"></a> [db\_parameter\_group\_name](#output\_db\_parameter\_group\_name) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_engine"></a> [engine](#output\_engine) | n/a |
| <a name="output_rds_cluster_id"></a> [rds\_cluster\_id](#output\_rds\_cluster\_id) | n/a |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | n/a |
<!-- END -->
