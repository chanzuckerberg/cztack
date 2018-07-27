variable "project" {
  type = "string"
}

variable "env" {
  type = "string"
}

variable "service" {
  description = "Name of the service to load secrets for."
  type        = "string"
}

variable "parameter_store_key_alias" {
  default     = "parameter_store_key"
  description = "Alias of the encryption key used to encrypt parameter store values."
  type        = "string"
}

variable "account_id" {
  type        = "string"
  description = "The account id for the policy."
}

variable "iam_path" {
  type    = "string"
  default = "/"
}
