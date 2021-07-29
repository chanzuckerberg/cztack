variable "role_name" {
  type        = string
  description = "Name of the role to create"
}

variable "s3_bucket_prefixes" {
  type        = list(any)
  description = "Limits role permissions to buckets with specific prefixes. Empty for all buckets."

  default = [
    "",
  ]
}

variable "iam_path" {
  type    = string
  default = "/"
}

variable "source_account_id" {
  type        = string
  default     = ""
  description = "The source AWS account to establish a trust relationship. Ignored if empty or not provided. DEPRECATED: Please use source_account_ids."
}

variable "source_account_ids" {
  type        = set(string)
  default     = []
  description = "The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided."
}

variable "saml_idp_arns" {
  type        = set(string)
  default     = []
  description = "The AWS SAML IDP arns to establish a trust relationship. Ignored if empty or not provided."
}

variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "service" {
  type        = string
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "owner" {
  type        = string
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)"
}
