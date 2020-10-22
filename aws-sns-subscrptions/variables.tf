variable project {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable env {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable service {
  type        = string
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable owner {
  type        = string
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable sns_configurations {
  type        = list(any)
  description = "List of objects containing the SNS configurations."
  default     = []
}

variable sns_topic_name {
  type        = string
  description = "SNS topic name. If not provided, use $project-$env-$service by default."
}