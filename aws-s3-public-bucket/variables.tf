variable "owner" {
  type        = string
  description = "Owner for tagging and naming."
}

variable "project" {
  type        = string
  description = "Project for tagging and naming."
}

variable "service" {
  type        = string
  description = "Service for tagging and naming."
}

variable "env" {
  type        = string
  description = "Env for tagging and naming."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket. Note that `-public` will be appended to `bucket_name`s that don't contain a `public` substring. This module will output the computed `bucket_name`."
}

variable "allow_public_list" {
  type        = bool
  description = "Allow public to list bucket contents."
  default     = false
}

variable "bucket_policy" {
  type        = string
  description = "A policy to attach to this bucket."
  default     = ""
}

variable "bucket_contents" {
  type        = string
  description = "Describe the data within this bucket."
}

variable "public_read_justification" {
  type        = string
  description = "Describe why this bucket must be public and what it is being used for."
}

variable "enable_versioning" {
  type        = bool
  description = "Keep old versions of objects in this bucket."
  default     = true
}

variable "require_tls" {
  type        = bool
  description = "Require TLS to read objects from this bucket."
  default     = true
}

variable "logging_bucket" {
  type        = object({ name = string, prefix = string })
  description = "Log bucket name and prefix to enable logs for this bucket"
  default     = null
}
