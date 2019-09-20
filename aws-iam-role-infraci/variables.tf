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
  type = "string"
  default = ""
  description = "The unique identifier (ARN) of the state file DynamoDB table"
}