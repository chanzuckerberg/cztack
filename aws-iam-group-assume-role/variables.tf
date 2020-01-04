variable "target_accounts" {
  type        = list
  description = "List of accounts in which this role should be assume-able."
}

variable "iam_path" {
  type        = string
  default     = "/"
  description = "The IAM path under which the group and policies will be created. Useful for avoiding naming conflicts."
}

variable "group_name" {
  type        = string
  description = "The name of the group this module will create."
}

variable "users" {
  type        = list
  default     = []
  description = "List of user's names who should be added to this group."
}

variable "target_role" {
  type        = string
  default     = ""
  description = "Name of the role to be assume-able. If not specified or given as empty string, then the group name will be used as the role name. "
}

# Pseudo depends_on because Terraform modules do not support depends_on
variable "dependencies" {
  default = []
  type    = list
}
