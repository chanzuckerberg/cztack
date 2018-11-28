variable "name_prefix" {
  type        = "string"
  description = "Creates a unique name for both the role and instance profile beginning with the specified prefix. Max 32 characters long."
}

variable "iam_path" {
  type        = "string"
  default     = "/"
  description = "The IAM path to the role."
}

variable "role_description" {
  type        = "string"
  description = "The description of the IAM role."
  default     = ""
}

variable "enable_ssm" {
  type        = "string"
  description = "Attach the appropriate policies to allow the instance to integrate with AWS Systems Manager."
  default     = "true"
}
