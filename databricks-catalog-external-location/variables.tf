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
}

variable "override_bucket_name_prefix" {
  description = <<-EOT
    Override prefix of newly-created S3 bucket as the storage root of the catalog.
    Defaults to $${project}-$${env} (full name: $${project}-$${env}-dbx-catalog-bucket).
  EOT
  type        = string
}

variable "override_role_name_infix" {
  description = <<-EOT
    Override infix of IAM role used for accessing newly-created bucket.
    Defaults to $${env} (full name: external_location_dbx_$${env}_aws_role)
  EOT
  type        = string
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
      catalog_prefix          = optional(string, "")
  }))
}
