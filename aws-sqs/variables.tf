variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "tags" {
  type        = object({ project : string, env : string, service : string, owner : string, managedBy : string })
  description = "Tags to apply to resources"
}

variable "sqs_name" {
  type        = string
  description = "The name of the SQS queue"
}

variable "redrive_allow_policy" {
  type = object({
    redrive_permission = string
    source_queue_arns  = optional(list(string), [])
  })
  default     = null
  description = "Optional redrive allow policy configuration. When provided, creates an aws_sqs_redrive_allow_policy resource. redrive_permission must be one of: 'allowAll', 'denyAll', or 'byQueue'. source_queue_arns is required when redrive_permission is 'byQueue'."
}