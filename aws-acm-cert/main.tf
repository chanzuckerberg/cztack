locals {
  tags = {
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
    managedBy = "terraform"
  }

  cert_validation_count = var.cert_subject_alternative_names_count + 1
}

resource "aws_acm_certificate" "cert" {
  domain_name               = var.cert_domain_name
  subject_alternative_names = var.subject_alternative_names_order == null ? keys(var.cert_subject_alternative_names) : var.subject_alternative_names_order
  validation_method         = "DNS"
  tags                      = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

# https://www.terraform.io/docs/providers/aws/r/acm_certificate_validation.html
resource "aws_route53_record" "cert_validation" {
  count = local.cert_validation_count

  name    = lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_name")
  type    = lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_type")
  zone_id = lookup(var.cert_subject_alternative_names, lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "domain_name"), var.aws_route53_zone_id)
  records = [lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_value")]
  ttl     = var.validation_record_ttl

  allow_overwrite = var.allow_validation_record_overwrite
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn
}
