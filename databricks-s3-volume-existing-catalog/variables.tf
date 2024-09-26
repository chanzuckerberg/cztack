
variable "workspace_name" {
  description = "Name of the Databricks catalog to add the volume to"
  type        = string
}

variable "catalog_name" {
  description = "Name of the Databricks existing catalog to add the volume to"
  type        = string
}

variable "catalog_owner" {
  description = "User or group name of the catalog owner"
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

variable "volume_name" {
  description = "Name of the Databricks volume to create"
  type        = string
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