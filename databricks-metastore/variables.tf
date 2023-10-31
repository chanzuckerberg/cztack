variable "databricks_external_id" {
  type        = string
  description = "External ID for Databricks account"
}

variable "tags" {
  type        = object({ project : string, env : string, service : string, owner : string })
  description = "Fogg generated tags for the environment"
}

variable "deletion_window_in_days" {
  type        = number
  description = "Deletion window in days for S3 encryption key"
  default     = 7
}

variable "enable_key_rotation" {
  type        = bool
  description = "Enable key rotation for S3 encryption key"
  default     = true
}

variable "delta_sharing_scope" {
  type        = string
  description = "Delta sharing scope"
  default     = "INTERNAL"
}

variable "delta_sharing_recipient_token_lifetime_in_seconds" {
  type        = number
  description = "Lifetime of delta sharing recipient token in seconds"
  default     = 3600
}

variable "force_destroy" {
  type        = bool
  description = "Force destroy metastore if data exists"
  default     = false
}

variable "workspaces" {
  type        = map(string)
  description = "Map of workspace names to ids to associate with this metastore"
  default     = {}
}

variable "admin_groups" {
  type        = list(string)
  description = "List of databricks groups to grant admin access for metastore; includes owner by default"
  default     = []
}

variable "owner" {
  type        = string
  description = "Owner of the metastore; should be a group display name"
  default     = "data-infra-admin"
}

variable "powerusers" {
  type        = list(string)
  description = "List of databricks groups to grant poweruser access for metastore"
  default     = ["powerusers"]
}

variable "workspace_url" {
  type        = string
  description = "URL of the workspace to use to create this metastore"
}
