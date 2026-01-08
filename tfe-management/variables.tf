variable "organization" {
  type = string
}

variable "repo" {
  type = string
}

variable "accounts" {
  type = any
}

variable "envs" {
  type = any
}

variable "ssh_key_name" {
  type    = string
  default = "czi-si-tfe"
}

variable "teams_with_admin_access" {
  type        = list(string)
  description = "Teams which can admin (state)."
  default     = []
}

variable "teams_with_write_access" {
  type        = list(string)
  description = "Teams which can write (state)."
  default     = []
}

variable "teams_with_read_access" {
  type        = list(string)
  description = "Teams which can view components in TFE."
  default     = []
}

variable "teams_with_plan_access" {
  type        = list(string)
  description = "Teams which can run a plan."
  default     = []
}

variable "auto_apply" {
  type        = bool
  description = "Automatically apply merged changes."
  default     = true
}

variable "default_terraform_version" {
  type        = string
  description = "Unless overridden in a component, use this terraform version."
  default     = "1.2.6"
}

variable "default_trigger_prefixes" {
  type        = list(string)
  description = "List of directories which will, by default, trigger runs."
  default     = []
}

variable "default_remote_apply" {
  type        = bool
  default     = true
  description = "Whether to allow local applies for this workspace"
}

variable "default_branch" {
  type        = string
  description = "The git branch used by default."
  default     = ""
}

variable "enable_global" {
  type        = bool
  description = "Enable the global component in TFE."
  default     = true
}

variable "env_defaults" {
  type        = any
  description = "A map of environment names to default configuration. Can be overwriten by each component."
  default     = {}
}

variable "tags" {
  type = object({ project : string, env : string, service : string, owner : string, managedBy : string })
}