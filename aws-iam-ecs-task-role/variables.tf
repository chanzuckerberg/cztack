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
