variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "service" {
  type        = string
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "owner" {
  type        = string
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "function_name" {
  type        = string
  description = "The name for the lambda function."
  default     = null
}

variable "lambda_cloudwatch_log_retention_in_days" {
  type        = number
  description = "Retention policy (in days) for Lambda function's logs in Cloudwatch"
  default     = null
}
