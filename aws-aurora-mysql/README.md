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
| apply_immediately |  | string | `false` | no |
| backtrack_window |  | string | `0` | no |
| database_name |  | string | - | yes |
| database_password |  | string | - | yes |
| database_subnet_group |  | string | - | yes |
| database_username |  | string | - | yes |
| db_parameters |  | list | `<list>` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| ingress_cidr_blocks |  | list | - | yes |
| instance_class |  | string | `db.t2.small` | no |
| instance_count |  | string | `1` | no |
| kms_key_id |  | string | `` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | - | yes |
| publicly_accessible |  | string | `false` | no |
| rds_cluster_parameters |  | list | `<list>` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | string | - | yes |
| skip_final_snapshot |  | string | `false` | no |
| vpc_id |  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| database_name |  |
| endpoint |  |

<!-- END -->
