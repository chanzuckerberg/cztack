locals {
  tags = {
    env       = var.env
    owner     = var.owner
    service   = var.service
    project   = var.project
    managedBy = "terraform"
  }
}

resource "aws_s3_bucket" "redirect_bucket" {
  bucket = (var.redirect_bucket_name == null) : "redirect-${var.source_domain}-to-${var.target_domain}" ? var.redirect_bucket_name
  
  website {
    redirect_all_requests_to = "https://${var.target_domain}"
  }

  tags = local.tags
}

module "security_headers_lambda" {
  source = "../aws-lambda-edge-add-security-headers"

  lambda_cloudwatch_log_retention_in_days = var.lambda_cloudwatch_log_retention_in_days

  project = var.project
  owner   = var.owner
  env     = var.env
  service = var.service
}

module "cert" {
  source              = "../aws-acm-certificate"
  cert_domain_name    = var.source_domain
  aws_route53_zone_id = var.source_domain_zone_id
  tags                = local.tags
}

resource "aws_cloudfront_distribution" "cf" {
  enabled = true
  comment = "Redirect requests from ${var.source_domain} to ${var.target_domain}."

  aliases = [var.source_domain]
  viewer_certificate {
    acm_certificate_arn      = module.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }

  origin {
    domain_name = aws_s3_bucket.redirect_bucket.website_endpoint
    origin_id   = "s3_www_redirect"
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"] # Irrelevant given line above, but required.
    }
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"

    target_origin_id = "s3_www_redirect"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type   = "origin-response"
      include_body = false
      lambda_arn   = module.security_headers_lambda.qualified_arn
    }

    min_ttl     = 0
    default_ttl = 300
    max_ttl     = 300
    compress    = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = local.tags
}

resource "aws_route53_record" "alias_ipv4" {
  zone_id = var.source_domain_zone_id
  name    = var.source_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias_ipv6" {
  zone_id = var.source_domain_zone_id
  name    = var.source_domain
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}
