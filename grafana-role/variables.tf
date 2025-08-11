variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "role_name_override" {
  description = "Override the default role name for the Grafana IAM role"
  type        = string
  default     = null
}

variable "tags" {
  type        = object({ project : string, env : string, service : string, owner : string, managedBy : string })
  description = "Tags to apply to resources"
}

variable "role_policy_json" {
  type        = string
  description = "JSON policy document for the IAM role (an output such as: data.aws_iam_policy_document.<name>.json)"
}
