variable "cert_domain_name" {
  type        = "string"
  description = "Like www.foo.bar.com or *.foo.bar.com"
}

variable "cert_subject_alternative_names" {
  type        = "map"
  description = "A map of <alternative_domain:route53_zone_id>"
  default     = {}
}

variable "aws_route53_zone_id" {
  type = "string"
}

variable "validation_record_ttl" {
  type    = "string"
  default = 60
}

variable "project" {
  type        = "string"
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "env" {
  type        = "string"
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "service" {
  type        = "string"
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "owner" {
  type        = "string"
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "allow_validation_record_overwrite" {
  type        = "string"
  description = "Allow the overwrite of validation records. This is needed if you are creating certificates in multiple regions."
  default     = true
}
