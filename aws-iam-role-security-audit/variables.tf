variable "source_account_id" {
  type        = "string"
  description = "The AWS account from which this role should be assumeable."
}

variable "role_name" {
  type        = "string"
  description = "The name of this role."
  default     = "/"
}
