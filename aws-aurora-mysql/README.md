# AWS Aurora MySQL

This module will create a robust and secure [AWS Aurora](https://aws.amazon.com/rds/aurora/) MySQL cluster.

A few things this module does for you–

* ensures that data is encrypted at rest, either via an AWS managed key or if you supply `kms_key_id` a key that you control (via KMS).
* tags all resources with our [consistent tags](../README.md#Consistent%20Tagging)
* sets some sane defaults for database and cluster parameters

A simple example:

```hcl
module "db" {
  source = "github.com/chanzuckerberg/cztack//aws-aurora-mysql?ref=v0.14.0"

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
| aws | >= 2.44.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apply\_immediately | If false changes will not be applied until next maintenance window. | `string` | `false` | no |
| auto\_minor\_version\_upgrade | Set the databases to automatically upgrade minor versions. | `bool` | `true` | no |
| backtrack\_window | Turns on Backgrack for this many seconds. [Doc](https://aws.amazon.com/blogs/aws/amazon-aurora-backtrack-turn-back-time/) | `string` | `0` | no |
| ca\_cert\_identifier | Identifier for the certificate authority. rds-ca-2019 is the latest available version. | `string` | `"rds-ca-2019"` | no |
| database\_name | The name of the database to be created in the cluster. | `string` | n/a | yes |
| database\_password | Password for user that will be created. | `string` | n/a | yes |
| database\_subnet\_group | The name of an existing database subnet group to use. | `string` | n/a | yes |
| database\_username | Default user to be created. | `string` | n/a | yes |
| db\_deletion\_protection | n/a | `string` | `false` | no |
| db\_parameters | Instance params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Reference.html#AuroraMySQL.Reference.Parameters.Instance) | `list` | <pre>[<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "general_log",<br>    "value": 1<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "slow_query_log",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "long_query_time",<br>    "value": "0"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "log_output",<br>    "value": "file"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "log_queries_not_using_indexes",<br>    "value": "1"<br>  }<br>]</pre> | no |
| engine\_version | The version of the engine to be used for aurora-mysql. | `string` | `"5.7"` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| iam\_database\_authentication\_enabled | n/a | `string` | `false` | no |
| ingress\_cidr\_blocks | A list of CIDR blocks that should be allowed to communicate with this Aurora cluster. | `list(string)` | `[]` | no |
| ingress\_security\_groups | A list of security groups that should be allowed to communicate with this Aurora cluster. | `list(string)` | `[]` | no |
| instance\_class | See valid instance types [here](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Managing.Performance.html) | `string` | `"db.t2.small"` | no |
| instance\_count | Number of instances to create in this cluster. | `string` | `1` | no |
| kms\_key\_id | If provided, storage will be encrypted with this key, otherwise an AWS-managed key is used. (Encryption is always on). | `string` | `""` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| params\_engine\_version | The engine version to be appended to the parameter group family. | `string` | `"5.7"` | no |
| performance\_insights\_enabled | n/a | `string` | `false` | no |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| publicly\_accessible | Avoid doing this - it gives access to the open internet. | `string` | `false` | no |
| rds\_cluster\_parameters | Cluster params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Reference.html#AuroraMySQL.Reference.Parameters.Cluster) | `list` | <pre>[<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "character_set_server",<br>    "value": "utf8"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "character_set_client",<br>    "value": "utf8"<br>  }<br>]</pre> | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| skip\_final\_snapshot | When you destroy a database RDS will, by default, take snapshot. Set this to skip that step. | `string` | `false` | no |
| vpc\_id | The id of the existing VPC in which this cluster should be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_name | n/a |
| db\_parameter\_group\_name | n/a |
| endpoint | n/a |
| engine | n/a |
| rds\_cluster\_id | n/a |
| reader\_endpoint | n/a |

<!-- END -->
