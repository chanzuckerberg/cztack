# ---- identity / tagging ----
variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket. Single source of truth for every ARN the module builds. Keep stable — external upload roles (shared-infra) hardcode it."
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

# ---- delivery ----
variable "delivery" {
  type        = string
  default     = "none"
  description = "How the bucket is served publicly. 'none' = private only. 'cloudfront' = OAC + distribution + geofence (+ CORS). Public access is only ever via CloudFront (so it stays geofenced)."

  validation {
    condition     = contains(["none", "cloudfront"], var.delivery)
    error_message = "delivery must be 'none' or 'cloudfront'."
  }
}

# ---- bucket passthroughs to aws-s3-private-bucket ----
variable "enable_versioning" {
  type        = bool
  default     = true
  description = "Keep old versions of overwritten objects."
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "cors_rules" {
  type        = any
  default     = []
  description = "S3-level CORS rules (rarely needed; CloudFront CORS is configured via var.cloudfront_cors)."
}

variable "kms_encryption" {
  type        = bool
  default     = null
  description = "Encrypt with a new customer-managed KMS key instead of SSE-S3. Null = SSE-S3."
}

variable "logging_bucket" {
  type        = object({ name = string, prefix = string })
  default     = null
  description = "S3 server-access-log destination bucket name + prefix."
}

variable "extra_bucket_policy_json" {
  type        = string
  default     = ""
  description = "Extra bucket policy JSON merged into the bucket policy (e.g. a log-delivery grant). Merged alongside the OAC read grant when delivery='cloudfront'; becomes the bucket policy when delivery='none'."
}

# ---- cloudfront (only used when delivery='cloudfront') ----
variable "region" {
  type        = string
  default     = null
  description = "Region for the S3 origin domain string. Defaults to the provider's region."
}

variable "price_class" {
  type    = string
  default = "PriceClass_100"
}

variable "cache_min_ttl" {
  type    = number
  default = 0
}

variable "cache_default_ttl" {
  type        = number
  default     = 31536000 # 1 year
  description = "Default cache TTL. Pass 0 for non-prod / always-revalidate buckets."
}

variable "cache_max_ttl" {
  type    = number
  default = 31536000 # 1 year
}

variable "cache_policy_id" {
  type        = string
  default     = null
  description = "Opt-in managed cache policy id. When set, the legacy forwarded_values block and min/default/max_ttl are omitted."
}

variable "compress" {
  type    = bool
  default = true
}

variable "viewer_protocol_policy" {
  type    = string
  default = "redirect-to-https"
}

variable "allowed_methods" {
  type    = list(string)
  default = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  type    = list(string)
  default = ["GET", "HEAD", "OPTIONS"]
}

variable "origin_id" {
  type        = string
  default     = null
  description = "CloudFront origin id. Defaults to '<bucket_name>-s3'. Override to match a legacy id and avoid distribution replacement on migration."
}

variable "oac_name" {
  type        = string
  default     = null
  description = "Origin Access Control name. Defaults to '<bucket_name>-oac'."
}

variable "response_headers_policy_name" {
  type        = string
  default     = null
  description = "CORS response-headers policy name. Defaults to '<bucket_name>-cors-policy'."
}

variable "distribution_comment" {
  type        = string
  default     = null
  description = "CloudFront distribution comment. Defaults to '<bucket_name> (S3, OAC)'."
}

# ---- geofence (single source of truth for the sanctioned-country list) ----
variable "geo_restriction_type" {
  type        = string
  default     = "blacklist"
  description = "CloudFront geo-restriction mode: 'blacklist', 'whitelist', or 'none'."

  validation {
    condition     = contains(["blacklist", "whitelist", "none"], var.geo_restriction_type)
    error_message = "geo_restriction_type must be 'blacklist', 'whitelist', or 'none'."
  }
}

variable "geo_restriction_locations" {
  type        = list(string)
  default     = ["CU", "IR", "KP", "SY", "UA"] # Cuba, Iran, North Korea, Syria, Ukraine
  description = "Country codes for the CloudFront geofence. Default is the org-wide export-sanctioned list."
}

# ---- CloudFront CORS response-headers policy ----
variable "cloudfront_cors" {
  type = object({
    enabled           = optional(bool, true)
    allow_origins     = optional(list(string), ["*"])
    allow_methods     = optional(list(string), ["GET", "HEAD", "OPTIONS"])
    allow_headers     = optional(list(string), ["Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"])
    expose_headers    = optional(list(string), ["Content-Length", "Content-Type"])
    allow_credentials = optional(bool, false)
    max_age_sec       = optional(number, 31536000)
    origin_override   = optional(bool, true)
  })
  default     = {}
  description = "CloudFront CORS response-headers policy config. Only used when delivery='cloudfront'."
}

# ---- cluster access: boto (IRSA — SDK access from a specific ServiceAccount) ----
variable "boto" {
  type = object({
    role_name   = string
    policy_name = optional(string)
    read_write  = optional(bool, false)
    prefix      = optional(string)
    trusts = list(object({
      oidc_provider_arn = string
      oidc_issuer_url   = string
      namespace         = string
      service_account   = string
      match_type        = optional(string, "StringEquals")
    }))
  })
  default     = null
  description = "Creates an IRSA role for in-cluster SDK (boto) access. 'trusts' may list multiple clusters; use match_type 'StringLike' for wildcard namespaces. 'prefix' scopes access to a key prefix."

  validation {
    condition     = var.boto == null ? true : length(var.boto.trusts) > 0
    error_message = "boto.trusts must contain at least one trust entry."
  }
}

# ---- cluster access: csi (attach to the shared Mountpoint-S3 driver role) ----
variable "csi" {
  type = object({
    policy_name = optional(string)
    read_write  = optional(bool, false)
    prefix      = optional(string)
    role_names  = list(string)
  })
  default     = null
  description = "Attaches an S3 access policy to the shared Mountpoint-S3 CSI driver role(s) so the bucket can be mounted into pods. role_names are the existing CSI driver role names."
}
