variable "project" {
  type = string
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "service" {
  type = string
}

variable "owner" {
  type = string
}

variable "kms_key_id" {
  type        = string
  description = "If supplied, EFS will use this key to encrypt data at rest. Empty string means that EFS will use an AWS-managed key. Encryption is always on with this module."
  default     = ""
}

variable "volume_name" {
  type = string
  description = "Name of the volume"
}

variable "vpc_id" {
  type = string
}

variable "cidr_blocks" {
  type        = list(string)
  default     = []
  description = "A list of CIDR blocks that should be allowed to communicate with this EFS volume"
}

variable "security_groups" {
  type        = list(string)
  description = "A list of security groups that should be allowed to communicate with this EFS volume."
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnets that need EFS targets created for this resource"
  default     = []
}
