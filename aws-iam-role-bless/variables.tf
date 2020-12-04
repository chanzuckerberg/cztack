variable "role_name" {
  type        = string
  description = "The name for the role"
}

variable "source_account_id" {
  type        = string
  description = "The source aws account id to allow sts:AssumeRole. DEPRECATED: Please use source_account_ids"
}

variable "source_account_ids" {
  type        = set(string)
  default     = []
  description = "The source aws account ids to allow sts:AssumeRole"
}

variable "bless_lambda_arns" {
  type        = list
  description = "List of bless lambda arns"
}

variable "iam_path" {
  type        = string
  default     = "/"
  description = "IAM path"
}

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
