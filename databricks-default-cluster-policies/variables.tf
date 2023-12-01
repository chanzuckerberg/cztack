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
  default = ""
}

variable "personal_compute_pool_ids" {
  description = "List of personal compute pool ids allowed"
  type = list(string)
  default = []
}
