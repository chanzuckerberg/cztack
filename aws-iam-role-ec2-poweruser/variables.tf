variable "role_name" {
  type = string
}

variable "iam_path" {
  type    = string
  default = "/"
}

variable "source_account_id" {
  type        = string
  default     = ""
  description = "The source AWS account to establish a trust relationship. Ignored if empty or not provided. DEPRECATED: Please use source_account_ids."
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

variable "iam_actions" {
  type        = list(string)
  default     = ["ec2:*"]
  description = "List of EC2 API Actions that we are granting this role. "
}

variable "iam_ec2_resources" {
  type        = list(string)
  default     = ["*"]
  description = "List of ARN's corresponding to specific EC2 instances. "
}

variable tags {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign this IAM Role."
}
