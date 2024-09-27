variable "catalog_name" {
  description = "Name of the Databricks existing catalog to add the volume to"
  type        = string
}

variable "catalog_owner" {
  description = "User or group name of the catalog owner"
  type        = string
}

variable "schema_name" {
  description = "Name of the Databricks schema to add the volume to"
  type        = string
}

variable "volume_buckets" {
  description = "List of external buckets and their corresponding groups that should have r/rw access to it"
  type        = list(object({
    bucket_name : string
    bucket_prefix: optional(string, "")
    volume_r_grant_principals: optional(list(string), [])
    volume_rw_grant_principals: optional(list(string), [])
  }))
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