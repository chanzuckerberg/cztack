variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "service" {
  description = "Name of the service to load secrets for."
  type        = string
}

variable "parameter_store_key_alias" {
  default     = "parameter_store_key"
  description = "Alias of the encryption key used to encrypt parameter store values."
  type        = string
}

variable "role_name" {
  description = "Name of the role to assign the policy to."
  type        = string
}

variable "region" {
  default     = "*"
  description = "Region the parameter store values can be read from. Defaults to all."
  type        = string
}

variable "extra_services" {
  type        = list(string)
  description = "Extra services to be given parameter read access to, within the same project and environment."
  default     = []
}