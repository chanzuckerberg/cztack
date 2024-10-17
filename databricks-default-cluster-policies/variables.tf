variable "databricks_workspace_id" {
  description = "Databricks workspace_id for tagging"
  type        = string
}

variable "databricks_host" {
  description = "Databricks host name for tagging"
  type        = string
}

variable "additional_instance_profile_arns" {
  description = "Additional instance profiles to allow clusters to run on"
  type        = list(string)
  default     = []
}

variable "databricks_log_bucket" {
  description = "Name of S3 bucket to store Databricks logs"
  type = string
}

variable "policy_name_prefix" {
  description = "Prefix for policy names"
  type = string
}

variable "personal_compute_pool_ids" {
  description = "List of personal compute pool ids allowed"
  type = list(string)
  default = []
}

variable "policy_map" {
  description = "Map of policy names to groups"
  type = list(map(list(string)))
}

variable "power_user_group_name" {
  description = "Name of the power user group"
  type = string
  default = "Power Users"
}
