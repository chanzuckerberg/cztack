variable "role_name" {
  type    = "string"
  default = "poweruser"
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


variable "iam_path" {
  type    = "string"
  default = "/"
}
