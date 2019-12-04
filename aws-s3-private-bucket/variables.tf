variable "bucket_name" {
  type = "string"
}

variable "bucket_policy" {
  type    = "string"
  default = ""
}

variable "project" {
  type = "string"
}

variable "env" {
  type = "string"
}

variable "service" {
  type = "string"
}

variable "owner" {
  type = "string"
}

variable "enable_versioning" {
  type        = bool
  description = "Keep old versions of overwritten S3 objects."
  default     = true
}

variable "abort_incomplete_multipart_upload_days" {
  type        = number
  description = "Number of days after which an incomplete multipart upload is canceled."
  default     = 14
}
