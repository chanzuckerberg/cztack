### TEST ONLY ####
variable "region" {
  type        = string
  description = "testonly: region for bless provider"
}

variable "bless_provider_aws_profile" {
  type = string
}

variable "test_user_name" {
  type = string
}

##################

### copied from bless ###
variable "iam_path" {
  type        = string
  default     = "/"
  description = "The IAM path under which the Bless lambda will be run."
}

variable "kmsauth_iam_group_name_format" {
  type        = string
  default     = "{}"
  description = "Formatting string to tell bless which IAM groups are relevant when checking SSH certificate principal validity."
}

variable "bless_logging_level" {
  type        = string
  default     = "INFO"
  description = "Bless lambda logging level."
}

variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../../README.md#consistent-tagging)"
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../../README.md#consistent-tagging)"
}

variable "service" {
  type        = string
  description = "Service for tagging and naming. See [doc](../../README.md#consistent-tagging)"
}

variable "owner" {
  type        = string
  description = "Owner for tagging and naming. See [doc](../../README.md#consistent-tagging)"
}
