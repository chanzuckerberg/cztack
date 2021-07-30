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

<<<<<<< HEAD
=======
variable "saml_idp_arn" {
  type        = string
  default     = ""
  description = "The AWS SAML IDP arn to establish a trust relationship. Ignored if empty or not provided."
}

>>>>>>> 8e5e5ca8d3c0c1f86613031c52f2302726e1a358
variable "source_account_ids" {
  type        = set(string)
  default     = []
  description = "The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided."
}

<<<<<<< HEAD
variable "saml_idp_arns" {
  type        = set(string)
  default     = []
  description = "The AWS SAML IDP arns to establish a trust relationship. Ignored if empty or not provided."
}

=======
>>>>>>> 8e5e5ca8d3c0c1f86613031c52f2302726e1a358
variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "service" {
  type        = string
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "owner" {
  type        = string
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)"
}
