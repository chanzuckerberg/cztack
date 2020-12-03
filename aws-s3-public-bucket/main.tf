locals {
  tags = {
    project         = var.project
    env             = var.env
    service         = var.service
    owner           = var.owner
    managedBy       = "terraform"
    isPublic        = true
    public_read_justification   = var.public_read_justification
    bucket_contents = var.bucket_contents
  }

  // make sure we have public in the name
  bucket_name = replace(var.bucket_name, "public", "") == var.bucket_name ? "${var.bucket_name}-public" : var.bucket_name
}

resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name

  policy = data.aws_iam_policy_document.bucket_policy.json

  versioning {
    enabled = true
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

data "aws_iam_policy_document" "bucket_policy" {
  # Deny access to bucket if it's not accessed through HTTPS
  source_json = var.bucket_policy

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
