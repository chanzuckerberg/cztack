variable "role_name" {
  type        = string
  description = "The name of the role to create."
}

variable "source_account_ids" {
  type        = set(string)
  description = "A set of accounts which are allowed to assume this role."
  default     = []
}

variable "saml_idp_arns" {
  type        = set(string)
  description = "A set of IDP SAML arns allowed to assume this role."
  default     = []
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

variable "iam_path" {
  type        = string
  description = "IAM path under which to create the role."
  default     = "/"
}

variable "all" {
  type    = bool
  default = false
}

variable "readonly" {
  type        = bool
  description = "Permit readonly access (across all services)."
  default     = true
}

variable "iam" {
  type        = bool
  description = "Permit IAMFullAccess (iam:*) for this role."
  default     = false
}

variable "route53" {
  type        = bool
  description = "Permit Route53 (route53:*) for this role."
  default     = false
}

variable "kms" {
  type = bool

  default = false
}

variable "config" {
  type = bool

  default = false
}

variable "acm" {
  type = bool

  default = false
}

variable "cloudwatch" {
  type = bool

  default = false
}

variable "cloudtrail" {
  type = bool

  default = false
}

variable "ecr" {
  type = bool

  default = false
}

variable "guardduty" {
  type = bool

  default = false
}

variable "kinesis" {
  type = bool

  default = false
}

variable "lambda" {
  type = bool

  default = false
}

variable "secretsmanager" {
  type = bool

  default = false
}

variable "securityhub" {
  type = bool

  default = false
}

variable "ssm" {
  type = bool

  default = false
}

variable "project" {
  type        = string
  description = ""
}

variable "service" {
  type        = string
  description = ""
}

variable "env" {
  type        = string
  description = ""
}

variable "owner" {
  type = string
}
