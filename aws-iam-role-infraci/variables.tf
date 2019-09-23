variable "source_account_id" {
  type = "string"
}

variable "role_name" {
  default = "infraci"
}

variable "iam_path" {
  default = "/"
}

variable "terraform_state_lock_dynamodb_arn" {
  type        = list(string)
  default     = []
  description = "ARNs of the state file DynamoDB tables"
}
