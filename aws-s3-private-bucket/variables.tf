variable "bucket_name" {
  type = string
}

variable "force_destroy" {
  type        = bool
  description = "Allow objects to be deleted when the bucket is destroyed without errors."
  default     = false
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

variable "transfer_acceleration" {
  type    = bool
  default = false
}

variable "logging_bucket" {
  type        = object({ name = string, prefix = string })
  description = "Log bucket name and prefix to enable logs for this bucket"
  default     = null
}

variable "public_access_block" {
  type    = bool
  default = true
}

variable "grants" {
  type        = any
  default     = []
  description = "A list of objects containing the grant configurations. Used when we want to grant permissions to AWS accounts via the S3 ACL system."
}

variable "acl" {
  type        = string
  default     = "private"
  description = "Canned ACL to use if grants object is not given. See https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html#canned-acl"
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

variable "kms_encryption" {
  type        = bool
  default     = null
  description = "Flag to indicate whether the bucket will be encrypted using a new customer-managed KMS key. Default behavior is no, and SSE-S3 is used instead. KMS is required for direct cross-account access (as opposed to via an assumed role in the target account)"
}

variable "kms_key_type" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "KMS key type with which to encrypt bucket"
  validation {
    condition     = var.kms_key_type == null ? true : contains(["SYMMETRIC_DEFAULT", "RSA_2048", "RSA_3072", "RSA_4096", "HMAC_256", "ECC_NIST_P256", "ECC_NIST_P384", "ECC_NIST_P521", "ECC_SECG_P256K1"], var.kms_key_type)
    error_message = "Valid values for var.kms_key_type are ('SYMMETRIC_DEFAULT', 'RSA_2048', 'RSA_3072', 'RSA_4096', 'HMAC_256', 'ECC_NIST_P256', 'ECC_NIST_P384', 'ECC_NIST_P521', 'ECC_SECG_P256K1')."

  }
}