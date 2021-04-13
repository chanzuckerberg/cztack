variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "service" {
  type        = string
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "owner" {
  type        = string
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "source_domain" {
  type        = string
  description = "The domain that will be redirected from."
}

variable "source_domain_zone_id" {
  type        = string
  description = "Route53 zone id for the source domain."
}

variable "target_domain" {
  type        = string
  description = "The domain that will be redirected to."
}
