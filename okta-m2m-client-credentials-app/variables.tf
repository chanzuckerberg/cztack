variable "tags" {
  description = "Standard tags"
  type = object({
    env : string,
    owner : string,
    project : string,
    service : string,
    managedBy : string,
  })
}

variable "okta_tenant" {
  type        = string
  description = "The Okta tenant to create the authorization server."
  default     = "czi-prod"
}

variable "scopes" {
  description = "Map of scope names to their configurations"
  type = map(object({
    metadata_publish = optional(string, "ALL_CLIENTS")
    consent          = optional(string, "IMPLICIT")
  }))
  default = {}
}

variable "label_prefix" {
  description = "Prefix for the Okta app label"
  type        = string
  default     = ""
}