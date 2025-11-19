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

variable "scopes" {
  description = "Map of scope names to their configurations"
  type = map(object({
    metadata_publish = optional(string, "ALL_CLIENTS")
    consent          = optional(string, "IMPLICIT")
  }))
  default = {}
}

variable "label" {
  description = "Label for the Okta app"
  type        = string
  default     = ""
}

variable "jwks" {
  description = "Optional JWKS configuration. If provided, KMS key will not be created and these JWKS values will be used instead. All fields are required if this variable is set."
  type = object({
    kid = string # Key ID
    kty = string # Key Type
    e   = string # Public exponent
    n   = string # Modulus
  })
  default   = null
  sensitive = true
}