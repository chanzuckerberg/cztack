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
  type = "string"
}

variable "ingress_cidr_blocks" {
  type = "list"
}

variable "instance_class" {
  type    = "string"
  default = "db.t2.small"
}

variable "instance_count" {
  type = "string"
  default = 1
}

variable "owner" {
  type = "string"
}

variable "project" {
  type = "string"
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
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "publicly_accessible" {
  default = false
}

variable "rds_cluster_parameters" {
  type = "list"

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
  type = "list"

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
  type    = "string"
  default = ""
}
