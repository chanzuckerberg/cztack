locals {
  tags = {
    project   = "${var.project}"
    env       = "${var.env}"
    service   = "${var.service}"
    owner     = "${var.owner}"
    managedBy = "terraform"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  acl    = "private"

  policy = "${data.aws_iam_policy_document.bucket_policy.json}"

  versioning {
    enabled = var.enable_versioning
  }

  # TODO
  #   logging {
  #   target_bucket = ""
  #   target_prefix = ""
  # }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = "${local.tags}"
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = "${aws_s3_bucket.bucket.id}"

  block_public_acls   = true
  block_public_policy = true
}

data "aws_iam_policy_document" "bucket_policy" {
  # Deny access to bucket if it's not accessed through HTTPS
  source_json = "${var.bucket_policy}"

  statement {
    sid       = "EnforceHTTPS"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    effect = "Deny"

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}
