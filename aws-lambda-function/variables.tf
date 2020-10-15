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

variable source_s3_bucket {
  type        = string
  description = "Bucket holding lambda source code."
  default     = null
}

variable source_s3_key {
  type        = string
  description = "Key identifying location of code."
  default     = null
}

variable handler {
  type        = string
  description = "Name of the lambda handler."
}

variable runtime {
  type        = string
  description = "Lambda language runtime."
}

variable timeout {
  type        = number
  description = "Execution timeout for the lambda."
  default     = null
}

variable environment {
  type        = map(string)
  description = "Map of environment variables."
  default     = {}
}

variable kms_key_arn {
  type        = string
  description = "KMS key used to encrypt environment variables."
  default     = null
}

variable source_code_hash {
  type    = string
  default = null
}

variable filename {
  type    = string
  default = null
}

variable log_retention_in_days {
  type    = number
  default = null
}

variable function_name {
  type        = string
  description = "If not set, function use default naming convention of $project-$env-$service. See local.name in main.tf"
  default     = null
}

variable function_description {
  type        = string
  description = "Description for lambda function."
  default     = ""
}

variable publish_lambda {
  type        = bool
  description = "Whether to publish creation/change as new lambda function version."
  default     = false
}

variable lambda_role_path {
  type        = string
  description = "The path to the IAM role for lambda."
  default     = null
}