locals {
  tags = {
    project                   = var.project
    env                       = var.env
    service                   = var.service
    owner                     = var.owner
    managedBy                 = "terraform"
    isPublic                  = true
    public_read_justification = var.public_read_justification
    bucket_contents           = var.bucket_contents
  }

  // make sure we have public in the name
  bucket_name = replace(var.bucket_name, "public", "") == var.bucket_name ? "${var.bucket_name}-public" : var.bucket_name
}

resource "aws_s3_bucket" "bucket" {
  bucket        = local.bucket_name
  force_destroy = var.force_destroy

  versioning {
    enabled = var.enable_versioning
  }

  dynamic "logging" {
    for_each = var.logging_bucket == null ? [] : [var.logging_bucket]
    content {
      target_bucket = var.logging_bucket.name
      target_prefix = var.logging_bucket.prefix
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = local.tags
}

# Disable public access block on the bucket
# https://repost.aws/knowledge-center/s3-block-public-access-setting
resource "aws_s3_bucket_public_access_block" "remove_public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
  # Wait for the public access block to be applied before applying the bucket policy
  depends_on = [aws_s3_bucket_public_access_block.remove_public_access]
}

data "aws_iam_policy_document" "bucket_policy" {
  # Deny access to bucket if it's not accessed through HTTPS
  source_policy_documents = var.bucket_policy == null || var.bucket_policy == "" ? [] : [var.bucket_policy]

  dynamic "statement" {
    for_each = var.require_tls ? ["enabled"] : []
    content {
      sid       = "EnforceTLS"
      actions   = ["s3:GetObject"]
      resources = ["arn:aws:s3:::${local.bucket_name}/*"]

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

  statement {
    sid       = "AllowPublicRead"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.bucket_name}/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.allow_public_list ? ["enabled"] : []

    content {
      sid       = "AllowPublicList"
      actions   = ["s3:ListBucket"]
      resources = ["arn:aws:s3:::${local.bucket_name}"]
      principals {
        type        = "*"
        identifiers = ["*"]
      }
    }
  }
}
