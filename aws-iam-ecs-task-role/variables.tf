variable "project" {
  type = "string"

  description = "High-level project, should be unique across the organization."
}

variable "env" {
  type = "string"

  description = "Environment name. For example– dev, staging or prod."
}

variable "service" {
  type = "string"

  description = "Name of this thing we're running."
}

variable "owner" {
  type = "string"

  description = "Email address of the owner. Can be a group address."
}

variable "policy_text" {
  type = "string"

  description = "The text of an IAM policy to create and  attach to this role. Not compatible with policy_arn."
}

variable "policy_arn" {
  type = "string"

  description = "The ARN of an existing IAM policy to attach to this role. Note compatible with policy_text."
}

# Validation
locals {
  valid = "${(var.policy_text == "" || var.policy_arn == "") && (var.policy_text != "" || var.policy_arn != "")}"
}

resource "null_resource" "validation" {
  count                                                                            = "${local.valid ? 0 : 1 }"
  "[ERROR] You may set one of `var.policy_text` or `var.policy_arn` but not both." = true
}
