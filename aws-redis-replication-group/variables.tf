
variable "tags" {
  type        = object({ project : string, env : string, service : string, owner : string, managedBy : string })
  description = "Tags to apply"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnets to which this EC instance should be attached. They should probably be private."
}

variable "preferred_cache_cluster_azs" {
  type        = list(string)
  description = "Availability zone in which this instance should run."
  default     = null
}

variable "ingress_security_group_ids" {
  type        = list(string)
  description = "Source security groups which should be able to contact this instance."
}

variable "port" {
  type        = number
  description = "Port to host Redis on."
  default     = 6379
}

variable "instance_type" {
  type        = string
  description = "The type of instance to run. See [supported node types](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html)"
  default     = "cache.m5.large"
}

variable "parameter_group_name" {
  type        = string
  description = "Parameter group to use for this Redis cache."
  default     = "default.redis5.0"
}

variable "engine_version" {
  type        = string
  description = "The version of Redis to run. See [supported versions](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/supported-engine-versions.html)"
  default     = "5.0.5"
}

variable "apply_immediately" {
  type        = bool
  description = "Whether changes should be applied immediately or during the next maintenance window."
  default     = true
}

# This is to get a around a limitation where the elasticache cluster id can be
# only 20 characters long. Use it only if you get that error.
variable "resource_name" {
  description = "If not set, name will be [var.project]-[var.env]-[var.name]."
  type        = string
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "VPC where the cache will be deployed."
}

variable "number_cache_clusters" {
  type        = number
  description = "Number of cache clusters. Default 1."
  default     = 1
}

variable "at_rest_encryption_enabled" {
  type        = bool
  description = "Whether to enable encryption at rest. Default: true."
  default     = true
}

variable "transit_encryption_enabled" {
  type        = bool
  description = "Whether to enable encryption in transit. Default: true."
  default     = true
}

variable "description" {
  type        = string
  description = "A user-created description for the replication group."
}

variable "auth_token" {
  type        = string
  description = "The password used to access a password protected server."
}