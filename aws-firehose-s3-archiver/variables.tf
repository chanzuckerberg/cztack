variable "bucket_name" {
  type        = string
  description = "Name of the bucket that will hold the logs."
}

variable "cloudwatch_filter_pattern" {
  type        = string
  description = "A cloudwatch filter expression to identify which cloudwatch log events get ingested into s3"
}

variable "log_group_name" {
  type        = string
  description = "The log group you're pulling events from. Should be from the same reason."
}

variable "name" {
  type        = string
  description = "Common name (identifier) to assign to all of the IAM resources in this module."
}

variable "s3_prefix" {
  type        = string
  description = "Folder prefix to assign to separate these files from other files in the bucket. Make sure you have a slash `/` at the end"
}

variable "enable_backup" {
  type        = bool
  description = "Whether you want to enable the collection of backup files in a raw/ folder."
  default     = false
}