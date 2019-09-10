variable "database_name" {
  type = "string"
}

variable "database_subnet_group" {
  type = "string"
}

variable "database_password" {
  type = "string"
}

variable "database_username" {
  type = "string"
}

variable "env" {
  type        = "string"
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "ingress_cidr_blocks" {
  type = "list"
}

variable "instance_class" {
  type    = "string"
  default = "db.t2.small"
}

variable "instance_count" {
  type    = "string"
  default = 1
}

variable "owner" {
  type        = "string"
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "project" {
  type        = "string"
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
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
  type        = "string"
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "vpc_id" {
  type = "string"
}

variable "publicly_accessible" {
  default = false
}

variable "rds_cluster_parameters" {
  type = "list"

  default = []
}

variable "db_parameters" {
  type = "list"

  default = []
}

variable "engine" {
  type = "string"
}

variable "kms_key_id" {
  type        = "string"
  description = "If supplied, RDS will use this key to encrypt data at rest. Empty string means that RDS will use an AWS-managed key. Encryption is always on with this module."
  default     = ""
}

variable "port" {
  type = "string"
}

variable "engine_version" {
  type = "string"
}

variable "iam_database_authentication_enabled" {
  type    = "string"
  default = true
}

variable "enabled_cloudwatch_logs_exports" {
  type    = "list"
  default = []
}

variable "performance_insights_enabled" {
  type    = "string"
  default = true
}

variable "db_cluster_parameter_group_name" {
  type    = "string"
  default = ""
}

variable "db_deletion_protection" {
  type = "string"
}
