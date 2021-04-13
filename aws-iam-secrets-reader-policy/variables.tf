variable "role_name" {
  type        = string
  description = "The role to which this policy should be attached."
}

variable "iam_path" {
  type    = string
  default = "/"
}

variable "secrets_arns" {
  type        = list(string)
  description = "List of secrets ARNs for reading."
}
