variable "vpc_id" {
  description = "ID of the VPC."
  type        = string
}

variable "private_subnets" {
  description = "List of private subnets."
  type        = list(string)
}

variable "databricks_external_id" {
  description = "The ID of a Databricks root account."
  type        = string
}

variable "project" {
  description = "A high level name, typically the name of the site."
  type        = string
}

variable "env" {
  description = "The environment / stage. Aka staging, dev, prod."
  type        = string
}

variable "service" {
  description = "The service. Aka databricks-workspace."
  type        = string
}

variable "owner" {
  type = string
}

variable "passable_role_arn" {
  description = "A role to allow the cross-account role to pass to other accounts"
  type        = string
  default     = ""
}

# check if argument is null or is in list (2nd parameter of contains() cannot be null)
variable "object_ownership" {
  type        = string
  default     = null
  description = "Set default owner of all objects within bucket (e.g., bucket vs. object owner)"

  validation {
    condition     = var.object_ownership == null ? true : contains(["BucketOwnerEnforced", "BucketOwnerPreferred", "ObjectWriter"], var.object_ownership)
    error_message = "Valid values for var.object_ownership are ('BucketOwnerEnforced', 'BucketOwnerPreferred', 'ObjectWriter')."

  }
}

variable "workspace_name_override" {
  type        = string
  default     = null
  description = "Override the workspace name. If not set, the workspace name will be set to the project, env, and service."
}

variable "tfe_service_principal_name" {
  type        = string
  default     = null
  description = "Name for the service principal for Terraform Enterprise, if available. Will be added as a workspace admin"
}