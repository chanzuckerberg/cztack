variable "group_name" {
  type        = "string"
  default     = "console-login"
  description = "Name of the group to be created."
}

variable "iam_path" {
  type        = "string"
  default     = "/"
  description = "IAM path under which resources will be created."
}
