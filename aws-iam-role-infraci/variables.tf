variable "role_name" {
  default = "infraci"
}

variable "iam_path" {
  default = "/"
}

variable "terraform_state_lock_dynamodb_arns" {
  type        = list(string)
  default     = []
  description = "ARNs of the state file DynamoDB tables"
}

variable "source_account_id" {
  type        = string
  default     = ""
  description = "The source AWS account to establish a trust relationship. Ignored if empty or not provided. DEPRECATED: Pleaase use source_account_ids."
}

variable "source_account_ids" {
  type        = set(string)
  default     = []
  description = "The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided."
}

variable "saml_idp_arn" {
  type        = string
  default     = ""
  description = "The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided."
}
