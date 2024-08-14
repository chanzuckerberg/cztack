variable "catalog_name" {
  description = "Name of the catalog"
  type        = string
}

variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
}

variable "isolation_mode" {
  description = "Isolation mode of the catalog"
  type        = string
  default     = "ISOLATED"
}

variable "catalog_owner" {
  description = "Owner of the catalog"
  type        = string
  default     = ""
}

variable "all_privileges_groups" {
  description = "Groups with all privileges"
  type        = list(string)
  default     = []
}

variable "read_privileges_groups" {
  description = "Groups with read privileges"
  type        = list(string)
  default     = []
}

variable "write_privileges_groups" {
  description = "Groups with write privileges"
  type        = list(string)
  default     = []
}
