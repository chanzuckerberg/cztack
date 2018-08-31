variable "database_name" {
  type        = "string"
  description = "The name of the database to be created in the cluster."
}

variable "database_subnet_group" {
  type        = "string"
  description = "The name of an existing database subnet group to use."
}

variable "database_password" {
  type        = "string"
  description = "Password for user that will be created."
}

variable "database_username" {
  type        = "string"
  description = "Default user to be created."
}

variable "env" {
  type        = "string"
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "ingress_cidr_blocks" {
  type        = "list"
  description = "A list of CIDR blocks that should be allowed to communicate with this Aurora cluster."
}

variable "instance_class" {
  type        = "string"
  description = "See valid instance types [here](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Managing.Performance.html)"
  default     = "db.t2.small"
}

variable "instance_count" {
  type        = "string"
  description = "Number of instances to create in this cluster."
  default     = 1
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
  type        = "string"
  description = "When you destroy a database RDS will, by default, take snapshot. Set this to skip that step."
  default     = false
}

variable "backtrack_window" {
  type        = "string"
  description = "Turns on Backgrack for this many seconds. [Doc](https://aws.amazon.com/blogs/aws/amazon-aurora-backtrack-turn-back-time/)"
  default     = 0
}

variable "apply_immediately" {
  type        = "string"
  description = "If false changes will not be applied until next maintenance window."
  default     = false
}

variable "service" {
  type        = "string"
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "vpc_id" {
  type        = "string"
  description = "The id of the existing VPC in which this cluster should be created."
}

variable "publicly_accessible" {
  type        = "string"
  description = "Avoid doing this - it gives access to the open internet."
  default     = false
}

variable "rds_cluster_parameters" {
  type        = "list"
  description = "Cluster params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Reference.html#AuroraMySQL.Reference.Parameters.Cluster)"

  default = [
    {
      name         = "character_set_server"
      value        = "utf8"
      apply_method = "pending-reboot"
    },
    {
      name         = "character_set_client"
      value        = "utf8"
      apply_method = "pending-reboot"
    },
  ]
}

variable "db_parameters" {
  type        = "list"
  description = "Instance params you can set. [Doc](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Reference.html#AuroraMySQL.Reference.Parameters.Instance)"

  default = [
    {
      name         = "general_log"
      value        = 1
      apply_method = "pending-reboot"
    },
    {
      name         = "slow_query_log"
      value        = "1"
      apply_method = "pending-reboot"
    },
    {
      name         = "long_query_time"
      value        = "0"
      apply_method = "pending-reboot"
    },
    {
      name         = "log_output"
      value        = "file"
      apply_method = "pending-reboot"
    },
    {
      name         = "log_queries_not_using_indexes"
      value        = "1"
      apply_method = "pending-reboot"
    },
  ]
}

variable "kms_key_id" {
  type        = "string"
  description = "If provided, storage will be encrypted with this key, otherwise an AWS-managed key is used. (Encryption is always on)."
  default     = ""
}
