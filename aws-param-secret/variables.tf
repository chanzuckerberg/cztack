variable "env" {
  type        = "string"
  description = "Env for tags. See [doc](../README.md#consistent-tagging)"
}

variable "project" {
  type        = "string"
  description = "Project for tags. See [doc](../README.md#consistent-tagging)"
}

variable "owner" {
  type        = "string"
  description = "Owner for tags. See [doc](../README.md#consistent-tagging)."
}

variable "service" {
  type        = "string"
  description = "Service for tags. See [doc](../README.md#consistent-tagging)"
}

variable "name" {
  type        = "string"
  description = "The name of the secret."
}

variable "use_paths" {
  default     = "true"
  description = "This exists to support data written by Chamber before version 2.0.0, which used '.' instead of '/' as a separator."
}
