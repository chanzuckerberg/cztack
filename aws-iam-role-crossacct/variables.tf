variable "role_name" {
  description = "The name of the role."
  type        = string
}

variable "iam_path" {
  default     = "/"
  description = "The IAM path to put this role in."
}

variable "source_account_ids" {
  type        = set(string)
  default     = []
  description = "The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided."
}

variable "saml_idp_arns" {
  type        = set(string)
  default     = []
  description = "The AWS SAML IDP arns to establish a trust relationship. Ignored if empty or not provided."
}

variable "source_role_arns" {
  type        = list(string)
  description = "The source AWS roles to establish a trust relationship. Ignored if empty or not provided."
  default     = []
}

variable "oidc" {
  type = list(object(
    {
      idp_arn : string,                      # the AWS IAM IDP arn
      client_ids : list(string),             # a list of oidc client ids
      provider : string,                     # your provider url, such as foo.okta.com
      jwt_condition : optional(string),      # the condition to allow the JWT token
      condition_operator : optional(string), # the condition operator for the iam statement
    }
  ))

  default     = []
  description = "A list of AWS OIDC IDPs to establish a trust relationship for this role."
}

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

variable "max_session_duration" {
  type        = number
  default     = 60 * 60 // 1 hour
  description = "The maximum session duration (in seconds) for the role."
}
