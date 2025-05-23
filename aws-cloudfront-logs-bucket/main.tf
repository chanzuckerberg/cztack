data "aws_canonical_user_id" "current_user" {}

module "aws-cloudfront-logs-bucket" {
  source                                 = "../aws-s3-private-bucket"
  env                                    = var.env
  owner                                  = var.owner
  project                                = var.project
  service                                = var.service
  bucket_name                            = var.bucket_name
  bucket_policy                          = var.bucket_policy
  enable_versioning                      = var.enable_versioning
  abort_incomplete_multipart_upload_days = var.abort_incomplete_multipart_upload_days
  public_access_block                    = var.public_access_block
  lifecycle_rules                        = var.lifecycle_rules
  kms_encryption                         = var.kms_encryption
}

resource "aws_s3_bucket_ownership_controls" "cloudfront-owner-preferred" {
  bucket = module.aws-cloudfront-logs-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "cloudfront-owner-grant" {
  depends_on = [aws_s3_bucket_ownership_controls.cloudfront-owner-preferred]

  bucket = module.aws-cloudfront-logs-bucket.id
  access_control_policy {
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current_user.id
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }

    grant {
      grantee {
        id   = "c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0" # AWS log delivery group's canonical user id
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }

    owner {
      id = data.aws_canonical_user_id.current_user.id
    }
  }
}