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

variable tags {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign this IAM Role."
}
