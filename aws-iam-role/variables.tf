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

variable "iam_path" {
  type        = string
  description = "The IAM path under which the IAM role will be created."
  default     = null
}

variable "max_session_duration" {
  type        = number
  description = "The maximum amount of time, in seconds, that a principal can assume this role."
  default     = 3600
}

// DEPRECATED: use saml_idps instead
variable "saml_idp_arns" {
  type        = set(string)
  default     = []
  description = "The AWS SAML IDP arns to establish a trust relationship. Ignored if empty or not provided."
}
variable "saml_idps" {
  type = list(object({
    saml_idp_arns : list(string),
    saml_auds : list(string)
  }))
  default     = []
  description = <<EOF
  The AWS SAML IDPs to establish a trust relationship.
  Ignored if empty or missing."
  If unsure, saml_auds would typically be ["https://signin.aws.amazon.com/saml"].

  EOF
}


variable "oidc" {
  type = list(object(
    {
      idp_arn : string,          # the AWS IAM IDP arn
      client_ids : list(string), # a list of oidc client ids
      provider : string          # your provider url, such as foo.okta.com
    }
  ))

  default     = []
  description = "A list of AWS OIDC IDPs to establish a trust relationship for this role."
}

variable "role_name" {
  type        = string
  description = "IAM role name."
}

variable "role_description" {
  type        = string
  description = "IAM role description."
  default     = null
}

variable "inline_policies" {
  type        = list(object({ name = string, policy = string }))
  description = "List of inline policies to be associated with the IAM role."
  default     = []
}

variable "attached_policies_names_arns" {
  type        = map(string)
  description = "Map of policy names to the respective ARNs to be attached to the IAM role."
  default     = {}
}

variable "source_account_ids" {
  type        = set(string)
  default     = []
  description = "The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided."
}
