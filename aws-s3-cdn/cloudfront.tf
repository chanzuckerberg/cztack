resource "aws_cloudfront_origin_access_control" "this" {
  count = local.is_cloudfront ? 1 : 0

  name                              = coalesce(var.oac_name, "${var.bucket_name}-oac")
  description                       = "OAC for ${var.bucket_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Grants the distribution read on the bucket. Scoped to this distribution's ARN so no other
# distribution can read the bucket. Resource is the static ARN to keep the graph acyclic.
data "aws_iam_policy_document" "oac" {
  count = local.is_cloudfront ? 1 : 0

  # Merge any caller-supplied extra policy alongside the OAC grant so it isn't silently dropped.
  source_policy_documents = var.extra_bucket_policy_json == "" ? [] : [var.extra_bucket_policy_json]

  statement {
    sid       = "AllowCloudFrontOACRead"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${local.bucket_arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.this[0].arn]
    }
  }
}

resource "aws_cloudfront_response_headers_policy" "cors" {
  count = local.is_cloudfront && var.cloudfront_cors.enabled ? 1 : 0

  name    = coalesce(var.response_headers_policy_name, "${var.bucket_name}-cors-policy")
  comment = "CORS policy for ${var.bucket_name}"

  cors_config {
    access_control_allow_credentials = var.cloudfront_cors.allow_credentials

    access_control_allow_headers {
      items = var.cloudfront_cors.allow_headers
    }
    access_control_allow_methods {
      items = var.cloudfront_cors.allow_methods
    }
    access_control_allow_origins {
      items = var.cloudfront_cors.allow_origins
    }
    access_control_expose_headers {
      items = var.cloudfront_cors.expose_headers
    }

    access_control_max_age_sec = var.cloudfront_cors.max_age_sec
    origin_override            = var.cloudfront_cors.origin_override
  }
}

resource "aws_cloudfront_distribution" "this" {
  count = local.is_cloudfront ? 1 : 0

  origin {
    domain_name              = local.origin_domain
    origin_id                = local.origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.this[0].id
  }

  comment     = coalesce(var.distribution_comment, "${var.bucket_name} (S3, OAC)")
  enabled     = true
  price_class = var.price_class

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_type == "none" ? [] : var.geo_restriction_locations
    }
  }

  default_cache_behavior {
    allowed_methods            = var.allowed_methods
    cached_methods             = var.cached_methods
    target_origin_id           = local.origin_id
    viewer_protocol_policy     = var.viewer_protocol_policy
    response_headers_policy_id = var.cloudfront_cors.enabled ? aws_cloudfront_response_headers_policy.cors[0].id : null
    compress                   = var.compress

    cache_policy_id = var.cache_policy_id

    min_ttl     = var.cache_policy_id == null ? var.cache_min_ttl : null
    default_ttl = var.cache_policy_id == null ? var.cache_default_ttl : null
    max_ttl     = var.cache_policy_id == null ? var.cache_max_ttl : null

    dynamic "forwarded_values" {
      for_each = var.cache_policy_id == null ? [1] : []
      content {
        query_string = false
        cookies {
          forward = "none"
        }
      }
    }
  }

  lifecycle {
    # CloudFront OAC can't decrypt SSE-KMS objects without granting the CloudFront service
    # principal kms:Decrypt on the CMK, which this module doesn't wire. Fail fast instead of
    # serving AccessDenied on every request.
    precondition {
      condition     = var.kms_encryption != true
      error_message = "delivery=\"cloudfront\" does not support kms_encryption. Use SSE-S3 (leave kms_encryption unset)."
    }

    precondition {
      condition     = var.geo_restriction_type == "none" || length(var.geo_restriction_locations) > 0
      error_message = "geo_restriction_type \"blacklist\"/\"whitelist\" requires at least one country in geo_restriction_locations; set geo_restriction_type = \"none\" to disable geofencing."
    }
  }
}
