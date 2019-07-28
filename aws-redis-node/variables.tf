variable "project" {
  type        = "string"
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "env" {
  type        = "string"
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "owner" {
  type        = "string"
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "subnets" {
  type        = "list"
  description = "List of subnets to which this EC instance should be attached. They should probably be private."
}

variable "availability_zone" {
  type        = "string"
  description = "Availability zone in which this instance should run."
}

variable "ingress_security_group_ids" {
  type        = "list"
  description = "Source security groups which should be able to contact this instance."
}

variable "service" {
  type        = "string"
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)"
  default     = "redis"
}

variable "port" {
  type    = "string"
  default = "6379"
}

variable "instance_type" {
  type        = "string"
  description = "The type of instance to run. See [supported node types](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html)"
  default     = "cache.m4.large"
}

variable "parameter_group_name" {
  default = "default.redis3.2"
}

variable "engine_version" {
  type        = "string"
  description = "The version of Redis to run. See [supported versions](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/supported-engine-versions.html)"
  default     = "4.0.10"
}

variable "apply_immediately" {
  type        = "string"
  description = "Whether changes should be applied immediately or during the next maintenance window."
  default     = true
}

# This is to get a around a limitation where the elasticache cluster id can be
# only 20 characters long. Use it only if you get that error.
variable "resource_name" {
  description = "If not set, name will be [var.project]-[var.env]-[var.name]."
  type        = "string"
  default     = ""
}
