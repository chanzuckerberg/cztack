variable "source_account_id" {
  type = "string"
}

variable "role_name" {
  type    = "string"
  default = "route53domains-poweruser"
}

variable "iam_path" {
  type    = "string"
  default = "/"
}
