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

variable "authorized_aws_accounts" {
  type        = map(string)
  description = "The map of authorized AWS accounts to assume the created role."
  default     = {}
}

variable "additional_assume_role_policies_json" {
  type        = string
  description = "The JSON string of any other additional assume role policies to add to the Github Actions role"
  default     = ""
}

variable "authorized_github_repo_conditions" {
  type = map(map(list(object({
    test   = string
    claim  = string
    values = list(string)
  }))))
  default     = {}
  description = <<DESCRIPTION
  Optional additional OIDC claim conditions applied per authorized repo.
  The outer key is the GitHub org and the inner key is the repo; both must also
  appear in authorized_github_repos. Each condition constrains a GitHub OIDC
  token claim (for example job_workflow_ref) and is ANDed onto that repo's trust
  statement, narrowing which workflows may assume the role. claim is a bare claim
  name; the module prefixes it with the GitHub OIDC provider hostname.
	DESCRIPTION
}