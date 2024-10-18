data "aws_canonical_user_id" "current_user" {}

data "aws_caller_identity" "current" {}

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
        id   =  data.aws_canonical_user_id.current_user.id
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

data "aws_iam_policy_document" "logs_bucket_kms_policy" {
  statement {
    sid = "Allow Cloudfront Access logs delivery to use the key"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }
  statement {
    sid = "Default permission"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
}

locals {
  aws_kms_key_id = var.kms_encryption != null ? split("/", module.aws-cloudfront-logs-bucket.bucket_kms_encryption_key_arn)[1] : ""
}

resource "aws_kms_key_policy" "log_bucket_kms_policy" {
  count = var.kms_encryption != null ? 1 : 0
  key_id = local.aws_kms_key_id
  policy = data.aws_iam_policy_document.logs_bucket_kms_policy.json
}
