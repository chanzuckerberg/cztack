resource "aws_acm_certificate" "cert" {
  domain_name               = var.cert_domain_name
  subject_alternative_names = keys(var.cert_subject_alternative_names)
  validation_method         = "DNS"
  tags                      = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  name    = each.value.name
  type    = each.value.type
  zone_id = lookup(var.cert_subject_alternative_names, each.key, var.aws_route53_zone_id)
  records = [each.value.record]
  ttl     = var.validation_record_ttl

  allow_overwrite = true # Needed if making cert in multiple regions, and for AWS Provider 3.0 conversion
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
