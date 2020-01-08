variable "alias_name" {
  description = "Chamber is hard coded to use a KMS alias with the name 'parameter_store_key'."
  default     = "parameter_store_key"
  type        = string
}

variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "env" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
  default     = ""
}

variable "service" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
  default     = ""
}

variable "owner" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}
