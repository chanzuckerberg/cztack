variable "role_name" {
  type        = string
  description = "Name of the role to create"
}

variable "s3_bucket_names" {
  type        = set(string)
  description = "Limits role permissions to buckets with specific prefixes. Empty for all buckets."

  default = [
    "",
  ]
}

variable "iam_path" {
  type    = string
  default = "/"
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
