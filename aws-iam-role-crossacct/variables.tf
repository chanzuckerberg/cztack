variable "role_name" {
  description = "The name of the role."
  type        = "string"
}

variable "iam_path" {
  default     = "/"
  description = "The IAM path to put this role in."
}

variable "source_account_id" {
  type        = "string"
  default     = ""
  description = "The source AWS account to establish a trust relationship. Ignored if empty or not provided."
}

variable "saml_idp_arn" {
  type        = "string"
  default     = ""
  description = "The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided."
}
