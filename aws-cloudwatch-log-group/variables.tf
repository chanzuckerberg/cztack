variable "project" {
  type        = "string"
  description = "The high-level project. [Doc](https://czi.quip.com/TBxAAAo70sa8#HJSACAjH8mS)"
}

variable "env" {
  type        = "string"
  description = "The compute environment. [Doc](https://czi.quip.com/TBxAAAo70sa8#HJSACAjH8mS)"
}

variable "service" {
  type        = "string"
  description = "The name of the service. [Doc](https://czi.quip.com/TBxAAAo70sa8#HJSACAjH8mS)"
}

variable "owner" {
  type        = "string"
  description = "The email address of the owner. Could be a group. [Doc](https://czi.quip.com/TBxAAAo70sa8#HJSACAjH8mS)"
}

variable "log_group_name" {
  type        = "string"
  description = "Name for the log group. If not set, it will be $project-$env-$service}"

  default = ""
}
