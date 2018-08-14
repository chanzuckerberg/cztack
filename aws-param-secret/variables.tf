variable "env" {
  type        = "string"
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "project" {
  type        = "string"
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "owner" {
  type        = "string"
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "service" {
  type        = "string"
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "name" {
  type        = "string"
  description = "The name of the secret."
}

variable "use_paths" {
  default     = "true"
  description = "This exists to support data written by Chamber before version 2.0.0, which used '.' instead of '/' as a separator."
}
