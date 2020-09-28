variable "bucket_name" {
  type = string
}

variable "bucket_policy" {
  type    = string
  default = ""
}

variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "service" {
  type = string
}

variable "owner" {
  type = string
}

variable "enable_versioning" {
  type        = bool
  description = "Keep old versions of overwritten S3 objects."
  default     = true
}

variable "abort_incomplete_multipart_upload_days" {
  type        = number
  description = "Number of days after which an incomplete multipart upload is canceled. The value for this variable is set for all lifecycle rules, to specify the abort_incomplete_multipart_upload_days for each rule, you can specify it in the lifecycle_rules variable."
  default     = 14
}

variable "lifecycle_rules" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default = [
    {
      enabled = true

      expiration = {
        expired_object_delete_marker = true
      }

      noncurrent_version_transition = {
        days          = 30
        storage_class = "STANDARD_IA"
      }

      noncurrent_version_expiration = {
        days = 365
      }
      # if abort_incomplete_multipart_upload_days is not specified in the rule, it will use var.abort_incomplete_multipart_upload_days for general cases
      abort_incomplete_multipart_upload_days = 7
    }
  ]
}

variable "cors_rules" {
  description = "List of maps containing the cors rule configuration objects."
  type        = any
  default     = []
}

variable transfer_acceleration {
  type    = bool
  default = false
}

variable public_access_block {
  type    = bool
  default = true
}

variable grants {
  type        = any
  default     = []
  description = "A list of objects containing the grant configurations. Used when we want to grant permissions to AWS accounts via the S3 ACL system."
}
