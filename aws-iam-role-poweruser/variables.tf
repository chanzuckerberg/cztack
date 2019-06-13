variable "role_name" {
  type    = "string"
  default = "poweruser"
}

variable "source_account_id" {
  type = "string"
}

variable "iam_path" {
  type    = "string"
  default = "/"
}

variable "authorized_regions" {
  type        = "list"
  default     = []
  description = "Authorized regions for this role. Empty list means all regions."
}

variable "enable_s3" {
  type    = "string"
  default = false
}
variable "enable_lambda" {
  type    = "string"
  default = false
}
variable "enable_kms" {
  type    = "string"
  default = false
}
