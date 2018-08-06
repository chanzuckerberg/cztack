variable "source_account_id" {
  type        = "string"
  description = "The AWS account from which this role should be assumeable."
}

variable "iam_path" {
  type    = "string"
  default = "/"
}

variable "role_name" {
  default = "readonly"
}
