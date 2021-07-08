variable "database_name" {
  type = string
}

variable "database_subnet_group" {
  type = string
}

variable "database_password" {
  type = string
}

variable "database_username" {
  type = string
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
  type    = string
  default = "db.t2.small"
}

variable "instance_count" {
  type    = string
  default = 1
}

variable "owner" {
  type        = string
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "snapshot_identifier" {
  type        = string
  description = "Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot."
  default     = null
}

variable "skip_final_snapshot" {
  default = false
}

variable "backtrack_window" {
  default = 0
}

variable "apply_immediately" {
  default = false
}

variable "service" {
  type        = string
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "vpc_id" {
  type = string
}

variable "publicly_accessible" {
  default = false
}

variable "rds_cluster_parameters" {
  type = list(any)

  default = []
}

variable "db_parameters" {
  type = list(any)

  default = []
}

variable "engine" {
  type = string
}

variable "kms_key_id" {
  type        = string
  description = "If supplied, RDS will use this key to encrypt data at rest. Empty string means that RDS will use an AWS-managed key. Encryption is always on with this module."
  default     = ""
}

variable "port" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "params_engine_version" {
  type = string
}

variable "iam_database_authentication_enabled" {
  type    = string
  default = true
}

variable "enabled_cloudwatch_logs_exports" {
  type    = list(any)
  default = []
}

variable "performance_insights_enabled" {
  type    = string
  default = true
}

variable "db_deletion_protection" {
  type    = string
  default = false
}

variable "ca_cert_identifier" {
  type        = string
  description = "Identifier for the certificate authority. Use rds-ca-2019 for anything new."
  default     = "rds-ca-2019"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Set the databases to automatically upgrade minor versions."
  default     = true
}
