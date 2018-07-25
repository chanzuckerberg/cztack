variable "target_accounts" {
  type        = "list"
  description = "List of accounts in which this role should be assume-able."
}

variable "path" {
  type    = "string"
  default = "/"
}

variable "group_name" {
  type = "string"
}

variable "users" {
  type        = "list"
  default     = []
  description = "List of users who should be added to this group."
}

variable "target_role" {
  type        = "string"
  default     = ""
  description = "Name of the role to be assume-able. If not specified or given as empty string, then the group name will be used as the role name. "
}

# Pseudo depends_on because Terraform modules do not support depends_on
variable depends_on {
  default = []
  type    = "list"
}
