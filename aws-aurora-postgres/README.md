# AWS Aurora Postgres

This module will created a robust and secure [AWS Aurora](https://aws.amazon.com/rds/aurora/) Postgres cluster.

A few things this module does for you–

* ensures that data is encrypted at rest, either via an AWS managed key or if you supply `kms_key_id` a key that you control (via KMS).
* tags all resources with our [consistent tags](../README.md#Consistent%20Tagging)
* sets some sane defaults for database and cluster parameters

A simple example:

```hcl
module "db" {
  source = "github.com/chanzuckerberg/cztack//aws-aurora-postgres?ref=v0.13.0"

  database_name         = "..."
  database_subnet_group = "..."
  database_password     = "..."
  database_password     = "..."
  
  vpc_id = "..."

  # Variables used for tagging
  env     = "..."
  project = "..."
  service = "..."
  owner   = "..."
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apply_immediately | If false changes will not be applied until next maintenance window. | string | `false` | no |
| database_name | The name of the database to be created in the cluster. | string | - | yes |
| database_password | Password for user that will be created. | string | - | yes |
| database_subnet_group | The name of an existing database subnet group to use. | string | - | yes |
| database_username | Default user to be created. | string | - | yes |
| db_parameters | Instance params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Reference.html#AuroraPostgreSQL.Reference.Parameters.Instance) | list | `<list>` | no |
| engine_version | The version of Postgres to use. | string | `9.6` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| ingress_cidr_blocks | A list of CIDR blocks that should be allowed to communicate with this Aurora cluster. | list | - | yes |
| instance_class | See valid instance types [here](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Managing.html) | string | `db.r4.large` | no |
| instance_count | Number of instances to create in this cluster. | string | `1` | no |
| kms_key_id | If provided, storage will be encrypted with this key, otherwise an AWS-managed key is used. (Encryption is always on). | string | `` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| performance_insights_enabled |  | string | `false` | no |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| publicly_accessible | Avoid doing this - it gives access to the open internet. | string | `false` | no |
| rds_cluster_parameters | Cluster params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Reference.html#AuroraPostgreSQL.Reference.Parameters.Cluster) | list | `<list>` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| skip_final_snapshot | When you destroy a database RDS will, by default, take snapshot. Set this to skip that step. | string | `false` | no |
| vpc_id | The id of the existing VPC in which this cluster should be created. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| database_name |  |
| endpoint |  |
| port |  |

<!-- END -->
