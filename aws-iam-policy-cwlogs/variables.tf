variable "role_name" {
  type        = "string"
  description = "The role to which this policy should be attached."
}

variable "iam_path" {
  type    = "string"
  default = "/"
}
