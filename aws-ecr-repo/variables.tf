variable "name" {
  type = string
}

variable "tags" {
  type = object({
    project : string,
    env : string,
    service : string,
    owner : string,
    managedBy : string
  })
  description = "Tags to apply to ECR repo"
}

variable "read_arns" {
  description = "ARNs of users/roles allowed to read images from the repository."
  type        = list(string)
  default     = []
}

variable "write_arns" {
  description = "ARNs of users/roles allowed to write images to the repository."
  type        = list(string)
  default     = []
}

variable "ecr_resource_policy" {
  description = "ECR resource-level policy, as JSON string"
  type        = string
  default     = null
}

variable "max_image_count" {
  description = "Maximum number of images to keep. ECR has a service limit of 1000 images. Ignored if lifecycle_policy is provided."
  type        = number
  default     = 100
}

variable "lifecycle_policy" {
  description = "ECR ifecycle policy, as JSON string. If provided, max_images is ignored."
  type        = string
  default     = ""
}

variable "allow_lambda_pull" {
  type        = bool
  description = "Whether lambda can pull this ECR"
  default     = false
}

variable "force_delete" {
  type        = bool
  description = "Allows this ECR repo to be automated deleted with terraform destroy. False by default"
  default     = false
}

variable "allow_tag_mutability" {
  type        = bool
  description = "Whether to allow tag mutability"
  default     = true
}

variable "enable_image_scan_on_push" {
  type        = bool
  description = "Whether to enable image scan on push"
  default     = false
}