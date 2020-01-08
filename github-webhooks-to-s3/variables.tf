variable "owner" {
  type        = string
  description = "Owner for tagging and naming."
}

variable "project" {
  type        = string
  description = "Project for tagging and naming."
}

variable "service" {
  type        = string
  description = "Service for tagging and naming."
}

variable "env" {
  type        = string
  description = "Env for tagging and naming."
}

variable "fqdn" {
  type        = string
  description = "The fqdn to expose the api gateway as"
}

variable "certificate_arn" {
  type        = string
  description = "A certificate in us-east-1 for var.fqdn"
}

variable "route53_zone_id" {
  type        = string
  description = "The route53 zone id for fqdn's domain"
}

variable "lambda_source_s3_bucket" {
  type        = string
  description = "The s3 bucket where to find the lambda executable"
  default     = "shared-infra-prod-assets"
}

variable "lambda_source_s3_key" {
  type        = string
  description = "The s3 key where to find the lambda executable"
  default     = "go-misc/lambdas/2019/06/03/github_to_firehose.zip"
}

variable "iam_path" {
  type    = string
  default = "/"
}

variable "s3_prefix" {
  type        = string
  default     = ""
  description = "Firehose will add this prefix to files it writes to the s3 bucket"
}
