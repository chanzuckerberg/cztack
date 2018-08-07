variable "alias_name" {
  description = "Chamber is hard coded to use a KMS alias with the name 'parameter_store_key'."
  default     = "parameter_store_key"
  type        = "string"
}
