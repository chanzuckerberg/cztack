variable "database_name" {
  type        = string
  description = "The name of the database to be created in the cluster."
}

variable "database_subnet_group" {
  type        = string
  description = "The name of an existing database subnet group to use."
}

variable "database_password" {
  type        = string
  description = "Password for user that will be created."
}

variable "database_username" {
  type        = string
  description = "Default user to be created."
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "A list of CIDR blocks that should be allowed to communicate with this Aurora cluster."
}

variable "ingress_security_groups" {
  type        = list(string)
  description = "A list of security groups that should be allowed to communicate with this Aurora cluster."
  default     = []
}

variable "instance_class" {
  type        = string
  description = "See valid instance types [here](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Managing.html)"
  default     = "db.r4.large"
}

variable "instance_count" {
  type        = string
  description = "Number of instances to create in this cluster."
  default     = 1
}

variable "owner" {
  type        = string
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "service" {
  type        = string
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "vpc_id" {
  type        = string
  description = "The id of the existing VPC in which this cluster should be created."
}

variable "publicly_accessible" {
  type        = string
  description = "Avoid doing this - it gives access to the open internet."
  default     = false
}

variable "snapshot_identifier" {
  type        = string
  description = "Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot."
  default     = null
}

variable "skip_final_snapshot" {
  type        = string
  description = "When you destroy a database RDS will, by default, take snapshot. Set this to skip that step."
  default     = false
}

variable "apply_immediately" {
  type        = string
  description = "If false changes will not be applied until next maintenance window."
  default     = false
}

variable "rds_cluster_parameters" {
  type        = list(any)
  description = "Cluster params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Reference.html#AuroraPostgreSQL.Reference.Parameters.Cluster)"
  default     = []
}

variable "db_parameters" {
  type        = list(any)
  description = "Instance params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Reference.html#AuroraPostgreSQL.Reference.Parameters.Instance)"
  default     = []
}

variable "kms_key_id" {
  type        = string
  description = "If provided, storage will be encrypted with this key, otherwise an AWS-managed key is used. (Encryption is always on)."
  default     = ""
}

variable "engine_version" {
  type        = string
  description = "The version of Postgres to use. This should be a *prefix* if auto version upgrades are enabled. (Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#engine_version)"
  default     = "10"
}

variable "performance_insights_enabled" {
  type    = string
  default = false
}

variable "iam_database_authentication_enabled" {
  type    = string
  default = false
}

variable "ca_cert_identifier" {
  type        = string
  description = "Identifier for the certificate authority."
  default     = "rds-ca-2019"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Set the databases to automatically upgrade minor versions. WARNING - if this is enabled, make sure engine_version is set to a *prefix* rather that a specific version so that TF won't try to downgrade DB's that have been auto-upgraded. Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#engine_version"
  default     = false
}
