variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "service" {
  type        = string
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "owner" {
  type        = string
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "parameters" {
  type        = map(any)
  description = "Map from parameter names to values to set."
}

// TODO(el): Remove once tf 0.12 is released
variable "parameters_count" {
  type        = string
  description = "HACK: The number of keys in var.parameters. To avoid hitting value of count cannot be computed."
}
