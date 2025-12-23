variable "role_name" {
  type    = string
  default = null
}

variable "ecr_repository_arns" {
  type = list(string)
}

variable "policy_path" {
  type    = string
  default = "/"
}

variable "policy_name" {
  type    = string
  default = ""
}

variable "tags" {
  type = object({
    project : string,
    service : string,
    env : string,
    owner : string,
    managedBy : string,
  })
}

variable "user_name" {
  type    = string
  default = null
}
