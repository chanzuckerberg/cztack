# AWS Aurora Postgres

This module will created a robust and secure [AWS Aurora](https://aws.amazon.com/rds/aurora/) Postgres cluster.

A few things this module does for you–

* ensures that data is encrypted at rest, either via an AWS managed key or if you supply `kms_key_id` a key that you control (via KMS).
* tags all resources with our [consistent tags](../README.md#Consistent%20Tagging)
* sets some sane defaults for database and cluster parameters

A simple example:

```hcl
module "db" {
  source = "github.com/chanzuckerberg/cztack//aws-aurora-postgres?ref=v0.14.0"

  database_name         = "..."
  database_subnet_group = "..."
  database_password     = "..."
  
  vpc_id              = "..."
  ingress_cidr_blocks = "...

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
| ca\_cert\_identifier | Identifier for the certificate authority. | `string` | `"rds-ca-2019"` | no |
| database\_name | The name of the database to be created in the cluster. | `string` | n/a | yes |
| database\_password | Password for user that will be created. | `string` | n/a | yes |
| database\_subnet\_group | The name of an existing database subnet group to use. | `string` | n/a | yes |
| database\_username | Default user to be created. | `string` | n/a | yes |
| db\_parameters | Instance params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Reference.html#AuroraPostgreSQL.Reference.Parameters.Instance) | `list` | `[]` | no |
| engine\_version | The version of Postgres to use. | `string` | `"10"` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| iam\_database\_authentication\_enabled | n/a | `string` | `false` | no |
| ingress\_cidr\_blocks | A list of CIDR blocks that should be allowed to communicate with this Aurora cluster. | `list(string)` | `[]` | no |
| ingress\_security\_groups | A list of security groups that should be allowed to communicate with this Aurora cluster. | `list(string)` | `[]` | no |
| instance\_class | See valid instance types [here](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Managing.html) | `string` | `"db.r4.large"` | no |
| instance\_count | Number of instances to create in this cluster. | `string` | `1` | no |
| kms\_key\_id | If provided, storage will be encrypted with this key, otherwise an AWS-managed key is used. (Encryption is always on). | `string` | `""` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| performance\_insights\_enabled | n/a | `string` | `false` | no |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| publicly\_accessible | Avoid doing this - it gives access to the open internet. | `string` | `false` | no |
| rds\_cluster\_parameters | Cluster params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Reference.html#AuroraPostgreSQL.Reference.Parameters.Cluster) | `list` | `[]` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| skip\_final\_snapshot | When you destroy a database RDS will, by default, take snapshot. Set this to skip that step. | `string` | `false` | no |
| vpc\_id | The id of the existing VPC in which this cluster should be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_name | n/a |
| endpoint | n/a |
| port | n/a |
| reader\_endpoint | n/a |

<!-- END -->
