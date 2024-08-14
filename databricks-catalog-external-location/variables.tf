variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "all_privileges_groups" {
  description = "List of group names to grant access to"
  type        = list(string)
}

variable "databricks_external_id" {
  description = "ID of the databricks external location"
  type        = string
}
