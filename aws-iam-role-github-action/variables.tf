variable "authorized_github_repos" {
  type        = map(list(string))
  description = <<DESCRIPTION
  A map that specifies the authorized repos to assume the created role.
  Keys specify the name of the GitHub org.
  Values specify the authorized repos within that org.
	DESCRIPTION
}

variable "role" {
  type = object({
    name : string,
  })
  description = "Configure the AWS IAM Role."
}

variable "tags" {
  type = object({
    env : string,
    owner : string,
    managedBy : string,
    project : string
    service : string
  })

  description = "Standard tagging."
}