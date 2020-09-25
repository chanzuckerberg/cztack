locals {
  # If grants are defined, we use `grant` to grant permissions, otherwise it will use the `acl` to grant permissions
  acl = length(var.grants) == 0 ? "private" : null

  # `canonical_user_id` and `uri` shuold be specified exclusively in each grant, so we skip the invalid inputs in grants
  # invalid input is the case that they are both or neither specified
  valid_grants = [ for grant in var.grants : {
      canonical_user_id    = lookup(grant, "canonical_user_id", null) 
      uri                  = lookup(grant, "uri", null) 
      permissions          = grant.permissions
    } if !(
            (lookup(grant, "canonical_user_id", null) != null && lookup(grant, "uri", null) != null) || 
            (lookup(grant, "canonical_user_id", null) == null && lookup(grant, "uri", null) == null)
          ) 
    ]

  tags = {
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
    managedBy = "terraform"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  # `grant` and `acl` conflict with each other - https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#acl

  # Using canned ACL will conflict with using grant ACL
  acl = local.acl

  dynamic "grant" {
    for_each = local.valid_grants

    content {
      id          = lookup(grant.value, "canonical_user_id", null)
      uri         = lookup(grant.value, "uri", null)
      permissions = grant.value.permissions
      type        = lookup(grant.value, "canonical_user_id", null) == null? "Group" : "CanonicalUser"
    }
  }

  policy = data.aws_iam_policy_document.bucket_policy.json

  versioning {
    enabled = var.enable_versioning
  }

  dynamic "cors_rule" {
    for_each = var.cors_rules

    content {
      allowed_headers = lookup(cors_rule.value, "allowed_headers", null)
      allowed_methods = lookup(cors_rule.value, "allowed_methods", null)
      allowed_origins = lookup(cors_rule.value, "allowed_origins", null)
      expose_headers  = lookup(cors_rule.value, "expose_headers", null)
      max_age_seconds = lookup(cors_rule.value, "max_age_seconds", null)
    }
  }

  acceleration_status = var.transfer_acceleration ? "Enabled" : "Suspended"

  # dynamic block used instead of simply assigning a variable b/c lifecycle_rule is configuration block
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules

    content {
      id                                     = lookup(lifecycle_rule.value, "id", null) #lookup() provides default value in case it does not exist in var.lifecycle_rules input
      prefix                                 = lookup(lifecycle_rule.value, "prefix", null)
      tags                                   = lookup(lifecycle_rule.value, "tags", null)
      enabled                                = lookup(lifecycle_rule.value, "enabled", false)
      abort_incomplete_multipart_upload_days = lookup(lifecycle_rule.value, "abort_incomplete_multipart_upload_days", 0)

      dynamic "expiration" {
        for_each = length(keys(lookup(lifecycle_rule.value, "expiration", {}))) == 0 ? [] : [lookup(lifecycle_rule.value, "expiration", {})]

        content {
          date                         = lookup(expiration.value, "date", null)
          days                         = lookup(expiration.value, "days", null)
          expired_object_delete_marker = lookup(expiration.value, "expired_object_delete_marker", null)
        }
      }

      dynamic "transition" {
        for_each = length(keys(lookup(lifecycle_rule.value, "transition", {}))) == 0 ? [] : [lookup(lifecycle_rule.value, "transition", {})]

        content {
          date          = lookup(transition.value, "date", null)
          days          = lookup(transition.value, "days", null)
          storage_class = lookup(transition.value, "storage_class", null)
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = length(keys(lookup(lifecycle_rule.value, "noncurrent_version_expiration", {}))) == 0 ? [] : [lookup(lifecycle_rule.value, "noncurrent_version_expiration", {})]

        content {
          days = lookup(noncurrent_version_expiration.value, "days", null)
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = length(keys(lookup(lifecycle_rule.value, "noncurrent_version_transition", {}))) == 0 ? [] : [lookup(lifecycle_rule.value, "noncurrent_version_transition", {})]

        content {
          days          = lookup(lifecycle_rule.value.noncurrent_version_transition, "days", null)
          storage_class = lookup(lifecycle_rule.value.noncurrent_version_transition, "storage_class", null)
        }
      }
    }
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
  tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  count = var.public_access_block ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "bucket_policy" {
  # Deny access to bucket if it's not accessed through HTTPS
  source_json = var.bucket_policy

  statement {
    sid     = "EnforceTLS"
    actions = ["*"]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*",
    ]

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
