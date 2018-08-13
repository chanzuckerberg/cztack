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
  type = "string"
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

variable "service" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "publicly_accessible" {
  default = false
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

variable "rds_cluster_parameters" {
  type = "list"

  default = []
}

variable "db_parameters" {
  type = "list"

  default = []
}

variable "kms_key_id" {
  type    = "string"
  default = ""
}
