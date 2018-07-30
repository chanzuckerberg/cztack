variable "env" {
  type        = "string"
  description = "The cloud env (ie staging, prod)."
}

variable "project" {
  type        = "string"
  description = "The project name (probably same as team)."
}

variable "service" {
  type        = "string"
  description = "The service."
}

variable "name" {
  type        = "string"
  description = "The name of the secret."
}

variable "use_paths" {
  default     = "true"
  description = "This exists to support data written by Chamber before version 2.0.0, which used '.' instead of '/' as a separator."
}
