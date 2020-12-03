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
  description = "The name of the bucket."
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
