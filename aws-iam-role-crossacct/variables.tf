variable "role_name" {
  description = "The name of the role."
  type        = "string"
}

variable "iam_path" {
  default     = "/"
  description = "The IAM path to put this role in."
}

variable "source_account_id" {
  description = "The AWS account id that should be able to assume this role."
  type        = "string"
}
