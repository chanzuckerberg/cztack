variable "name_prefix" {
  type        = string
  description = "Creates a unique name for both the role and instance profile beginning with the specified prefix. Max 32 characters long."
}

variable "existing_role_name" {
  type        = string
  description = "Use existing role with the given name instead of creating a new role. Attaches all standard policies to given role. Only used if create_role is false."
  default     = null
}

variable "create_role" {
  type        = bool
  description = "Creates a role for use with the instance profile."
  default     = true
}

variable "iam_path" {
  type        = string
  default     = "/"
  description = "The IAM path to the role."
}

variable "role_description" {
  type        = string
  description = "The description of the IAM role."
  default     = ""
}
