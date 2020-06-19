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
  description = "Number of days after which an incomplete multipart upload is canceled."
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
    }
  ]
}

variable public_access_block {
  type    = bool
  default = true
}

variable canonical_user_id_and_permissions {
  type    = list(object({ canonical_user_id : string, permissions : list(string) }))
  default = []
  # A smaple of canonical_user_id_and_permissions variable is: 
  # canonical_user_id_and_permissions = [
  #   {
  #     canonical_user_id = "user1-canonical-user-ID"
  #     permissions = ["FULL_CONTROL"]
  #   },
  #   {
  #     canonical_user_id = "user2-canonical-user-ID"
  #     permissions = ["READ", "WRITE"]
  #   },
  # ]
  description = "A list of canonical user ID to permissions pairs. Used when we want to grant certain permissions to certain AWS accounts with canonical ID."
}
