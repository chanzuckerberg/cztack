variable "tags" {
  type        = object({ project : string, env : string, service : string, owner : string, managedBy : string })
  description = "Tags to apply"
}

variable "ecr_repository_prefix" {
  type        = string
  description = "The repository name prefix to use when caching images from the source registry."
}

variable "upstream_registry_url" {
  type        = string
  description = "The registry URL of the upstream public registry to use as the source."
}

variable "credential_arn" {
  type        = string
  description = "ARN of the Secret which will be used to authenticate against the registry."
}