locals {
  tags = {
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
    managedBy = "terraform"
  }

  is_cloudfront = var.delivery == "cloudfront"

  region = coalesce(var.region, data.aws_region.current.region)

  # Built from the bucket_name STRING (never module.bucket.arn) so the
  # bucket -> distribution -> OAC-policy -> bucket-policy graph stays acyclic.
  bucket_arn    = "arn:aws:s3:::${var.bucket_name}"
  origin_id     = coalesce(var.origin_id, "${var.bucket_name}-s3")
  origin_domain = "${var.bucket_name}.s3.${local.region}.amazonaws.com"
}

data "aws_region" "current" {}

module "bucket" {
  source = "../aws-s3-private-bucket"

  bucket_name = var.bucket_name
  # Stays private/deny-all regardless of the child module's default. OAC read (a service
  # principal + SourceArn condition) is not "public", so BPA doesn't block it.
  public_access_block = true
  bucket_policy       = local.is_cloudfront ? data.aws_iam_policy_document.oac[0].json : var.extra_bucket_policy_json
  enable_versioning   = var.enable_versioning
  force_destroy       = var.force_destroy
  cors_rules          = var.cors_rules
  logging_bucket      = var.logging_bucket
  kms_encryption      = var.kms_encryption

  project = var.project
  env     = var.env
  service = var.service
  owner   = var.owner
}
