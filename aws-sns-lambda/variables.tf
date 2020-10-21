variable project {
  type        = string
  description = "Project for tagging and naming."
}

variable env {
  type        = string
  description = "Env for tagging and naming."
}

variable service {
  type        = string
  description = "Service for tagging and naming"
}

variable owner {
  type        = string
  description = "Owner for tagging and naming."
}

variable lambda_environment {
  type        = map
  description = "Environment for lambda."
  default     = {}
}

variable function_description {
  type        = string
  description = "Description for the lambda function."
  default     = ""
}

variable publish_lambda {
  type        = bool
  description = "Whether to publish creation/change as new Lambda Function Version."
  default     = false
}

variable lambda_role_path {
  type        = string
  description = "Path of the IAM role for lambda."
  default     = null
}

variable lambda_handler {
  type        = string
  description = "Name of the lambda handler."
}

variable lambda_runtime {
  type        = string
  description = "Lambda language runtime."
}

variable lambda_timeout {
  type        = number
  description = "Execution timeout for the lambda."
  default     = null
}

variable lambda_source_code_hash {
  type        = string
  description = "Lambda source code, used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file."
  default     = null
}

variable lambda_zip_file {
  type        = string
  description = "The path to the function's deployment package within the local filesystem."
}

variable log_retention_in_days {
  type        = number
  description = "The number of days to retain log events in the log group for lambda."
  default     = null
}

variable lambda_function_name {
  type        = string
  description = "Name for lambda function. If not set, function use default naming convention of $project-$env-$service."
  default     = null
}

variable sns_configurations {
  type        = list(any)
  description = "List of objects containing the SNS configurations."
  default     = []
}
