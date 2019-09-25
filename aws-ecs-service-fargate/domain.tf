locals {
  fqdn = join(".", compact([var.subdomain, data.aws_route53_zone.zone.name]))
}

data "aws_route53_zone" "zone" {
  zone_id = var.route53_zone_id
}

resource "aws_route53_record" "ipv4" {
  zone_id = var.route53_zone_id
  name    = local.fqdn
  type    = "A"

  allow_overwrite = false

  alias {
    name                   = aws_lb.service.dns_name
    zone_id                = aws_lb.service.zone_id
    evaluate_target_health = true
  }
}

# The following DNS records only exist if doing HTTP redirect

resource "aws_route53_record" "ipv6" {
  count   = var.disable_http_redirect ? 0 : 1
  zone_id = var.route53_zone_id
  name    = local.fqdn
  type    = "AAAA"

  alias {
    name                   = aws_lb.service.dns_name
    zone_id                = aws_lb.service.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www-ipv4" {
  count   = var.disable_http_redirect ? 0 : 1
  zone_id = var.route53_zone_id
  name    = "www.${local.fqdn}"
  type    = "A"

  alias {
    name                   = aws_lb.service.dns_name
    zone_id                = aws_lb.service.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www-ipv6" {
  count   = var.disable_http_redirect ? 0 : 1
  zone_id = var.route53_zone_id
  name    = "www.${local.fqdn}"
  type    = "AAAA"

  alias {
    name                   = aws_lb.service.dns_name
    zone_id                = aws_lb.service.zone_id
    evaluate_target_health = true
  }
}
