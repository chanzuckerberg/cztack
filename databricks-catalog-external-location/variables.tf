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

variable "external_location_name" {
  description = "Name of the external location"
  type        = string
  default     = local.external_location_name
}

variable "catalogs" {
  description = "List of catalogs to create with their cooresponding attributes"
  type = list(
    object({
      name                    = string
      isolation_mode          = optional(string, "ISOLATED")
      owner                   = string
      all_privileges_groups   = list(string)
      read_privileges_groups  = optional(list(string), [])
      write_privileges_groups = optional(list(string), [])
  }))
}
