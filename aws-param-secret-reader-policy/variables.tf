variable "project" {
  type        = "string"
  description = "Project for tags. See [doc](../README.md#consistent-tagging)"
}

variable "env" {
  type        = "string"
  description = "Env for tags. See [doc](../README.md#consistent-tagging)."
}

variable "service" {
  description = "Name of the service to load secrets for."
  type        = "string"
}

variable "parameter_store_key_alias" {
  default     = "parameter_store_key"
  description = "Alias of the encryption key used to encrypt parameter store values."
  type        = "string"
}

variable "iam_path" {
  type    = "string"
  default = "/"
}

variable "role_name" {
  description = "Name of the role to assign the policy to."
  type        = "string"
}
