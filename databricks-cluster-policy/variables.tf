variable "policy_name" {
  description = "Name of cluster policy"
  type        = string
}

variable "databricks_workspace_id" {
  description = "Databricks workspace_id for tagging"
  type        = string
}

variable "databricks_host" {
  description = "Databricks host name for tagging"
  type        = string
}

variable "policy_family_id" {
  description = "ID of policy family to inherit from"
  type        = string
  default     = null
}

variable "policy_overrides" {
  description = "Cluster policy overrides"
  type        = any
  default     = {}
}

variable "grantees" {
  description = "Names of groups to be granted use access to the policy - must already exist"
  type        = list(string)
  default     = []
}