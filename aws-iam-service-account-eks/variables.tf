variable "eks_cluster" {
  type = object({
    cluster_id : string,
    cluster_arn : string,
    cluster_endpoint : string,
    cluster_ca : string,
    cluster_oidc_issuer_url : string,
    cluster_version : string,
    worker_iam_role_name : string,
    worker_security_group : string,
    oidc_provider_arn : string,
  })
  description = "eks-cluster module output"
}

variable "k8s_namespace" {
  description = "Kubernetes namespace that the service account is in"
  type        = string
}

variable "iam_path" {
  type        = string
  default     = ""
  description = "IAM path for the role."
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = ""
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "aws_iam_policies_json" {
  type        = list(string)
  description = "The additional AWS IAM policies to give to the pod. Backward compatibility with aws_iam_policy_json"
  default     = []
}

variable "aws_iam_policy_json" {
  type        = string
  description = "The AWS IAM policy to give to the pod."
}

variable "service_account_name" {
  type        = string
  default     = ""
  description = "Specified Service Account Name in case "
}

variable "tags" {
  type = object({ project : string, env : string, service : string, owner : string, managedBy : string })
  description = "Basic metadata about the service account"
}