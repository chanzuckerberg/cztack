variable "table_arn" {
  type = string
}

variable "role_name" {
  type        = string
  description = "optional role to attach this policy to."
  default     = null
}

variable "tags" {
  type        = object({ project : string, env : string, service : string, owner : string, managedBy : string })
  description = "Tags to apply to policy"
}
