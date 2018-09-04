# AWS Aurora MySQL

This module will created a robust and secure [AWS Aurora](https://aws.amazon.com/rds/aurora/) MySQL cluster.

A few things this module does for you–

* ensures that data is encrypted at rest, either via an AWS managed key or if you supply `kms_key_id` a key that you control (via KMS).
* tags all resources with our [consistent tags](../README.md#Consistent%20Tagging)
* sets some sane defaults for database and cluster parameters

A simple example:

```hcl
module "db" {
  source = "github.com/chanzuckerberg/cztack//aws-aurora-mysql?ref=v0.13.0"

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
| backtrack_window | Turns on Backgrack for this many seconds. [Doc](https://aws.amazon.com/blogs/aws/amazon-aurora-backtrack-turn-back-time/) | string | `0` | no |
| database_name | The name of the database to be created in the cluster. | string | - | yes |
| database_password | Password for user that will be created. | string | - | yes |
| database_subnet_group | The name of an existing database subnet group to use. | string | - | yes |
| database_username | Default user to be created. | string | - | yes |
| db_parameters | Instance params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Reference.html#AuroraMySQL.Reference.Parameters.Instance) | list | `<list>` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| iam_database_authentication_enabled |  | string | `false` | no |
| ingress_cidr_blocks | A list of CIDR blocks that should be allowed to communicate with this Aurora cluster. | list | - | yes |
| instance_class | See valid instance types [here](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Managing.Performance.html) | string | `db.t2.small` | no |
| instance_count | Number of instances to create in this cluster. | string | `1` | no |
| kms_key_id | If provided, storage will be encrypted with this key, otherwise an AWS-managed key is used. (Encryption is always on). | string | `` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| performance_insights_enabled |  | string | `false` | no |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| publicly_accessible | Avoid doing this - it gives access to the open internet. | string | `false` | no |
| rds_cluster_parameters | Cluster params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Reference.html#AuroraMySQL.Reference.Parameters.Cluster) | list | `<list>` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| skip_final_snapshot | When you destroy a database RDS will, by default, take snapshot. Set this to skip that step. | string | `false` | no |
| vpc_id | The id of the existing VPC in which this cluster should be created. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| database_name |  |
| endpoint |  |

<!-- END -->
