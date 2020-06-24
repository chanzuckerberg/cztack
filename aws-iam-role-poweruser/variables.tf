variable "role_name" {
  type    = string
  default = "poweruser"
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

variable "iam_path" {
  type    = string
  default = "/"
}

variable oidc {
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

variable authorize_iam {
  type        = bool
  default     = true
  description = "Indicates if we should augment the PowerUserAccess policy with certain IAM actions."
}

variable tags {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign this IAM Role."
}
