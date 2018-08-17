variable "role_name" {
  type        = "string"
  description = "The name for the role"
}

variable "source_account_id" {
  type        = "string"
  description = "The source aws account id to allow sts:AssumeRole"
}

variable "bless_lambda_arns" {
  type        = "list"
  description = "List of bless lambda arns"
}

variable "iam_path" {
  type        = "string"
  default     = "/"
  description = "IAM path"
}
