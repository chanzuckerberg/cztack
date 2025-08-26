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