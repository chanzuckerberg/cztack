variable "source_account_ids" {
  type        = list(string)
  description = "The source AWS account IDs to establish a trust relationship. Ignored if empty or not provided."
}

variable "saml_idp_arns" {
  type        = list(string)
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