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

variable "users" {
  type        = "list"
  default     = []
  description = "The IAM Users to add to this group."
}
