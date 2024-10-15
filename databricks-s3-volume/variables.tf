
variable "workspace_name" {
  description = "Name of the Databricks catalog to add the volume to"
  type        = string
}

variable "catalog_name" {
  description = "Name of the Databricks existing catalog to add the volume to"
  type        = string
}

variable "owner" {
  description = "User or group name of the owner - will be applied to the catalog, schema, and volume, if applicable"
  type        = string
}

variable "create_catalog" {
  description = "Flag to create a new catalog or look for an existing one with the given name"
  type        = bool
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

variable "volume_bucket" {
  description = "(Optional) Name of an existing S3 bucket to use for Databricks volume. NOTE: if provided, you will need to update the bucket policy whereever it is defined to allow Databricks access"
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

variable "catalog_r_grant_principals" {
  description = "(Optional) Databricks groups to grant read-only permissions to on the catalog"
  type        = list(string)
  default     = []
}

variable "catalog_rw_grant_principals" {
  description = "(Optional) Databricks groups to grant read/write permissions to on the catalog"
  type        = list(string)
  default     = []
}

variable "schema_r_grant_principals" {
  description = "(Optional) Databricks groups to grant read-only permissions to on the schema"
  type        = list(string)
  default     = []
}

variable "schema_rw_grant_principals" {
  description = "(Optional) Databricks groups to grant read/write permissions to on the schema"
  type        = list(string)
  default     = []
}

variable "volume_r_grant_principals" {
  description = "(Optional) Databricks groups to grant read-only permissions to on the volume"
  type        = list(string)
  default     = []
}

variable "volume_rw_grant_principals" {
  description = "(Optional) Databricks groups to grant read/write permissions to on the volume"
  type        = list(string)
  default     = []
}

variable "additional_rw_bucket_grant_arns" {
  description = "(Optional) Additional AWS ARNs to grant read/write permissions to on the bucket (may be necessary for service principals, instance profiles, or users"
  type        = list(string)
  default     = []
}

variable "override_policy_documents" {
  description = "(Optional) Additional bucket policies to apply to the bucket. These should already be in JSON"
  type        = list(string)
  default     = []
}

variable "create_storage_credential" {
  description = "(Optional) Flag to create a new Databricks storage credential or look for an existing one for the given bucket_name"
  type        = bool
  default     = true
}

variable "override_bucket_name" {
  description = "(Optional) Name of the S3 bucket to create or use for Databricks volume, overriding the default"
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