variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
}

variable "databricks_external_location_iam_role" {
  description = "Name of the role for instance profiles"
  type        = string
}

variable "name_prefix" {
  description = "Prefix to apply to resources"
  type        = string
}

variable "group_names" {
  description = "List of group names to grant access to"
  type        = list(string)
}

variable "databricks_external_id" {
  description = "ID of the databricks external location"
  type        = string
}
