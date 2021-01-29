variable project {
  type = string
}
variable env {
  type = string
}
variable service {
  type = string
}
variable owner {
  type = string
}
variable subdomain {
  type = string
}
variable aws_route53_zone_id {
  type = string
}

data aws_route53_zone zone {
  zone_id = var.aws_route53_zone_id
}

locals {
  domain       = replace(data.aws_route53_zone.zone.name, "/\\.$/", "")
  website_fqdn = "${var.subdomain}.${local.domain}"
  aliases = [
    "www.${local.website_fqdn}",
  ]
}

module cert {
  source = "../../aws-acm-cert"

  cert_domain_name                     = local.website_fqdn
  aws_route53_zone_id                  = var.aws_route53_zone_id
  cert_subject_alternative_names       = { for a in local.aliases : a => var.aws_route53_zone_id }
  cert_subject_alternative_names_count = length(local.aliases)

  project = var.project
  env     = var.env
  service = var.service
  owner   = var.owner
}

module site {
  source = "../."

  subdomain           = var.subdomain
  aws_acm_cert_arn    = module.cert.arn
  aws_route53_zone_id = var.aws_route53_zone_id

  project = var.project
  env     = var.env
  service = var.service
  owner   = var.owner
}
