variable "vpc_name_suffix" {
  description = "Suffix to append to the VPC name, like `-$${var.service}`, defaults to blank for backwards compatibility"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "IP address range for the VPC."
  type        = string
}

variable "azs" {
  description = "EC2 availability zones for the VPC."
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "public_subnet_cidrs" {
  description = "List of IP ranges for the public subnets. Must be same length as var.azs."
  type        = list(any)
}

variable "private_subnet_cidrs" {
  description = "List of IP ranges for the private subnets. Must be same length as var.azs."
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "List of IP ranges for the database subnets. Must be same length as var.azs."
  type        = list(string)
}

variable "create_database_subnet_route_table" {
  type        = bool
  default     = false
  description = "Controls if separate route table for database should be created."
}

variable "k8s_cluster_names" {
  description = "A list of k8s cluster names that will live in this vpc. We use these to tag vpc resources appropriately. See https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html"
  type        = list(string)
  default     = []
}

variable "vpc_flow_log_retention_in_days" {
  type        = number
  description = "Number of days to retain VPC flow logs."
  default     = 0
}

variable "skip_az_checks" {
  description = "Do not set to true for new VPCs; used to support legacy VPCs that violate 1:1 az to subnet constraint"
  default     = false
  type        = bool
}

variable "vpc_endpoints" {
  description = "List of VPC endpoints to create"
  type = list(object({
    enabled = bool
    service = string
    region  = optional(string)
  }))
  default = []
}