variable "env" {
  description = "Environment name"
  type        = string
}

variable "add_reader" {
  description = "Flag to add reader role for logs - should only be invoked for the ie workspace"
  type        = bool
  default     = false
}

variable "bucket_kms_encryption_key_arn" {
  description = "ARN for KMS key used to encrypt bucket for cluster logs"
  type        = string
}

variable "existing_role_names" {
  description = "List of other existing instance policy roles on the workspace for which to add cluster log write permissions"
  type        = list(string)
  default     = []
}

variable "databricks_logs_bucket_name" {
  description = "Name of the bucket to store cluster logs"
  type        = string
}

variable "global_reader_env" {
  description = "Name of env to grant global logs reader access to"
  type        = string
}

variable "destination_account_id" {
  description = "Account ID for the logs destination AWS account"
  type = string
}

variable "destination_account_region" {
  description = "Region for the logs destination AWS account"
  type = string
}

variable "destination_account_assume_role_name" {
  description = "Role name to assume in the logs destination AWS account"
  type = string
}