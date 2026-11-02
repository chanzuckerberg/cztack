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
  default     = null
}

variable "override_role_name_infix" {
  description = <<-EOT
    Override infix of IAM role used for accessing newly-created bucket.
    Defaults to $${env} (full name: external_location_dbx_$${env}_aws_role)
  EOT
  type        = string
  default     = null
}

variable "external_location_extra_grants" {
  description = <<-EOT
    (Optional) Grants on the external location for existing principals, in addition to `all_privileges_groups`.
    `principal` is a principal name (group name, user email, or service principal application ID), not a member ID.
    For example, grant a job's service principal CREATE_EXTERNAL_VOLUME to let it create external Volumes.
  EOT
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = []
}

variable "catalogs" {
  description = <<-EOT
    List of catalogs to create with their cooresponding attributes.

    `<code>_members` (usg, r, rw, crt, all, mng) are member IDs added to the catalog's built-in tier groups.
    `extra_groups` creates additional `<catalog>_<key>` groups with the given privileges and member IDs.
    `extra_grants` grants privileges to existing principals by name.
    Catalog grants are authoritative: anything not listed here is revoked.
  EOT
  type = list(
    object({
      name                           = string
      isolation_mode                 = optional(string, "ISOLATED")
      enable_predictive_optimization = optional(string, "INHERIT")
      owner                          = string
      catalog_prefix                 = optional(string, "")

      usg_members = optional(list(string), [])
      r_members   = optional(list(string), [])
      rw_members  = optional(list(string), [])
      crt_members = optional(list(string), [])
      all_members = optional(list(string), [])
      mng_members = optional(list(string), [])

      extra_groups = optional(map(object({
        privileges = list(string)
        members    = optional(list(string), [])
      })), {})
      extra_grants = optional(list(object({
        principal  = string
        privileges = list(string)
      })), [])

      # Renamed in 0.3.0. Kept only so the validation below can reject them;
      # without them Terraform silently drops the old attributes and every
      # membership is removed.
      all_privileges_members    = optional(list(string))
      manage_privileges_members = optional(list(string))
      read_privileges_members   = optional(list(string))
      write_privileges_members  = optional(list(string))
      use_privileges_members    = optional(list(string))
  }))

  validation {
    condition = alltrue([
      for c in var.catalogs : alltrue([
        for old in [
          c.all_privileges_members,
          c.manage_privileges_members,
          c.read_privileges_members,
          c.write_privileges_members,
          c.use_privileges_members,
        ] : old == null
      ])
    ])
    error_message = <<-EOT
      The *_privileges_members attributes were renamed in 0.3.0:
        all_privileges_members    -> all_members
        manage_privileges_members -> mng_members
        read_privileges_members   -> r_members
        write_privileges_members  -> rw_members (rw no longer grants CREATE_SCHEMA; add crt_members for that)
        use_privileges_members    -> usg_members
    EOT
  }

  validation {
    condition = alltrue([
      for c in var.catalogs : alltrue([for key in keys(c.extra_groups) : can(regex("^[a-z0-9_]+$", key))])
    ])
    error_message = "extra_groups keys must contain only lowercase letters, digits, and underscores."
  }
}