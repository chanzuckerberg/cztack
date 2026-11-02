
variable "workspace_name" {
  description = "Name of the Databricks catalog to add the volume to"
  type        = string
}

variable "create_catalog" {
  description = "Flag to create a new catalog or look for an existing one with the given name"
  type        = bool
}

variable "catalog_name" {
  description = "Name of the Databricks existing catalog to add the volume to"
  type        = string
}

variable "create_volume_bucket" {
  type    = bool
  default = false
}

variable "create_catalog_bucket" {
  type    = bool
  default = false
}

variable "catalog_bucket_name" {
  description = "(Optional) Override storage root of catalog instead of using bucket name"
  type        = string
  default     = null
}

variable "owner" {
  description = "User or group name of the owner - will be applied to the catalog, schema, and volume, if applicable"
  type        = string
}

variable "owner_id" {
  description = "User or group id of the owner - will be applied to the catalog, schema, and volume, if applicable"
  type        = string
}

variable "metastore_id" {
  description = "ID of metastore to create catalog in"
  type        = string
}

variable "schema_name" {
  description = "Name of the Databricks schema to add the volume to"
  type        = string
}

variable "create_schema" {
  description = "Flag to create a new catalog or look for an existing one with the given name"
  type        = bool
}

variable "volume_name" {
  description = "Name of the Databricks volume to create"
  type        = string
}

variable "volume_bucket_name" {
  description = "(Optional) Name of S3 bucket to use for Databricks volume. NOTE: if provided, you will need to update the bucket policy whereever it is defined to allow Databricks access"
  type        = string
  default     = null
}

variable "volume_comment" {
  description = "(Optional) Comment to add to the Databricks volume"
  type        = string
  default     = "Managed by Terraform - this is a default volume for the Databricks workspace"
}

variable "volume_schema_properties" {
  description = "Properties of the Databricks schema to add the volume to"
  type        = map(string)
  default     = {}
}

# check if argument is null or is in list (2nd parameter of contains() cannot be null)
variable "bucket_object_ownership" {
  type        = string
  default     = null
  description = "Set default owner of all objects within bucket (e.g., bucket vs. object owner)"

  validation {
    condition     = var.bucket_object_ownership == null ? true : contains(["BucketOwnerEnforced", "BucketOwnerPreferred", "ObjectWriter"], var.bucket_object_ownership)
    error_message = "Valid values for var.object_ownership are ('BucketOwnerEnforced', 'BucketOwnerPreferred', 'ObjectWriter')."

  }
}

variable "catalog_mng_members" {
  description = "(Optional) Member IDs to add to the catalog's _manage group (ALL_PRIVILEGES, MANAGE). Owner is included"
  type        = list(string)
  default     = []
}

variable "catalog_all_members" {
  description = "(Optional) Member IDs to add to the catalog's _all group (ALL_PRIVILEGES). Owner is included"
  type        = list(string)
  default     = []
}

variable "catalog_r_members" {
  description = "(Optional) Member IDs to add to the catalog's _read group"
  type        = list(string)
  default     = []
}

variable "catalog_rw_members" {
  description = "(Optional) Member IDs to add to the catalog's _write group"
  type        = list(string)
  default     = []
}

variable "catalog_crt_members" {
  description = "(Optional) Member IDs to add to the catalog's _create group (USE_CATALOG, CREATE_SCHEMA)"
  type        = list(string)
  default     = []
}

variable "catalog_usg_members" {
  description = "(Optional) Member IDs to add to the catalog's _use group (USE_CATALOG)"
  type        = list(string)
  default     = []
}

variable "schema_mng_members" {
  description = "(Optional) Member IDs to add to the schema's _manage group (ALL_PRIVILEGES, MANAGE). Owner is included"
  type        = list(string)
  default     = []
}

variable "schema_all_members" {
  description = "(Optional) Member IDs to add to the schema's _all group (ALL_PRIVILEGES). Owner is included"
  type        = list(string)
  default     = []
}

variable "schema_r_members" {
  description = "(Optional) Member IDs to add to the schema's _read group"
  type        = list(string)
  default     = []
}

variable "schema_rw_members" {
  description = "(Optional) Member IDs to add to the schema's _write group"
  type        = list(string)
  default     = []
}

variable "schema_usg_members" {
  description = "(Optional) Member IDs to add to the schema's _use group (USE_SCHEMA)"
  type        = list(string)
  default     = []
}

variable "volume_mng_members" {
  description = "(Optional) Member IDs to add to the volume's _manage group (ALL_PRIVILEGES, MANAGE)"
  type        = list(string)
  default     = []
}

variable "volume_all_members" {
  description = "(Optional) Member IDs to add to the volume's _all group (ALL_PRIVILEGES)"
  type        = list(string)
  default     = []
}

variable "volume_r_members" {
  description = "(Optional) Member IDs to add to the volume's _read group (READ_VOLUME)"
  type        = list(string)
  default     = []
}

variable "volume_rw_members" {
  description = "(Optional) Member IDs to add to the volume's _write group (READ_VOLUME, WRITE_VOLUME)"
  type        = list(string)
  default     = []
}

variable "catalog_extra_groups" {
  description = "(Optional) Additional `<catalog>_<key>` groups, with their catalog privileges and member IDs. Only used when create_catalog is true. Keys can't be a tier code or suffix"
  type = map(object({
    privileges = list(string)
    members    = optional(list(string), [])
  }))
  default = {}

  validation {
    condition     = alltrue([for key in keys(var.catalog_extra_groups) : can(regex("^[a-z0-9_]+$", key))])
    error_message = "catalog_extra_groups keys must contain only lowercase letters, digits, and underscores."
  }
}

variable "schema_extra_groups" {
  description = "(Optional) Additional `<catalog>_<schema>_<key>` groups, with their schema privileges and member IDs. Only used when create_schema is true. Keys can't be a tier code or suffix"
  type = map(object({
    privileges = list(string)
    members    = optional(list(string), [])
  }))
  default = {}

  validation {
    condition     = alltrue([for key in keys(var.schema_extra_groups) : can(regex("^[a-z0-9_]+$", key))])
    error_message = "schema_extra_groups keys must contain only lowercase letters, digits, and underscores."
  }
}

variable "volume_extra_groups" {
  description = "(Optional) Additional `<catalog>_<schema>_<volume>_<key>` groups, with their volume privileges and member IDs. Keys can't be a tier code or suffix"
  type = map(object({
    privileges = list(string)
    members    = optional(list(string), [])
  }))
  default = {}

  validation {
    condition     = alltrue([for key in keys(var.volume_extra_groups) : can(regex("^[a-z0-9_]+$", key))])
    error_message = "volume_extra_groups keys must contain only lowercase letters, digits, and underscores."
  }
}

variable "catalog_extra_grants" {
  description = "(Optional) Catalog grants for existing principals, by name (group name, user email, or service principal application ID). Only used when create_catalog is true; catalog grants are authoritative"
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = []
}

variable "schema_extra_grants" {
  description = "(Optional) Schema grants for existing principals, by name (group name, user email, or service principal application ID). Only used when create_schema is true"
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = []
}

variable "volume_extra_grants" {
  description = "(Optional) Volume grants for existing principals, by name (group name, user email, or service principal application ID)"
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = []
}

variable "additional_rw_bucket_grant_arns" {
  description = "(Optional) Additional AWS ARNs to grant read/write permissions to on the bucket (may be necessary for service principals, instance profiles, or users"
  type        = list(string)
  default     = []
}

variable "override_policy_documents" {
  description = "(Optional) Additional bucket policies to apply to the buckets. Mapped by bucket name. These should already be in JSON"
  type        = map(list(string))
  default     = {}
}

variable "create_volume_storage_credentials" {
  description = "(Optional) Flag to create a new Databricks storage credential for the volume or look for an existing one for the given bucket_name"
  type        = bool
  default     = true
}

variable "create_catalog_storage_credentials" {
  description = "(Optional) Flag to create a new Databricks storage credential for the catalog or look for an existing one for the given bucket_name"
  type        = bool
  default     = true
}

variable "volume_storage_location" {
  description = "(Optional) Prefix to use for the storage location in case of an existing bucket (e.g. 's3://bucket' or 's3://bucket/prefix')"
  type        = string
  default     = null
}

variable "read_only_volume" {
  description = "(Optional) Flag to set volume as read-only"
  type        = bool
  default     = false
}

variable "enable_file_events" {
  description = "(Optional) Flag to enable file events on the external locations"
  type        = bool
  default     = false
}

variable "file_event_queue_url" {
  description = "(Optional) URL of an existing SQS queue to use for file events on the external locations. If set (and enable_file_events is true), a user-provided SQS queue is used; otherwise a Databricks-managed SQS queue is created."
  type        = string
  default     = null
}

variable "override_unity_aws_role_name" {
  description = "(Optional) Override the default Unity Catalog AWS IAM role name used when creating storage credentials"
  type        = string
  default     = null
}

variable "tags" {
  description = "REQUIRED: Tags to include for this environment."
  type = object({
    project : string
    env : string
    service : string
    owner : string
    managedBy : string
  })
}