variable "principal_name" {
  type        = "string"
  default     = ""
  description = "Name of the ssh principal this group authorizes."
}

variable "iam_path" {
  type        = "string"
  default     = "/"
  description = "IAM path under which resources will be created."
}
