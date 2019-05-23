locals {
  tags = {
    project   = "${var.project}"
    env       = "${var.env}"
    service   = "${var.service}"
    owner     = "${var.owner}"
    managedBy = "terraform"
  }

  cert_validation_count = "${length(var.cert_subject_alternative_names) + 1}"
}

resource "aws_acm_certificate" "cert" {
  domain_name               = "${var.cert_domain_name}"
  # subject_alternative_names = ["${keys(var.cert_subject_alternative_names)}"]
  subject_alternative_names = ["${var.cert_subject_alternative_names}"]
  validation_method         = "DNS"
  tags                      = "${local.tags}"

  lifecycle {
    create_before_destroy = true
    ignore_changes = ["subject_alternative_names"]
  }
}

# locals {
#   sorted_domain_validation_options = ["${sort(aws_acm_certificate.cert.domain_validation_options)}"]
# }

# https://www.terraform.io/docs/providers/aws/r/acm_certificate_validation.html
resource "aws_route53_record" "cert_validation" {
  count = "${local.cert_validation_count}"
  # count = "${length(aws_acm_certificate.cert.domain_validation_options)}"
  
  # name    = "${lookup(local.sorted_domain_validation_options[count.index], "resource_record_name")}"
  # type    = "${lookup(local.sorted_domain_validation_options[count.index], "resource_record_type")}"
  # zone_id = "${lookup(var.cert_subject_alternative_name_to_zone_id_map, lookup(local.sorted_domain_validation_options[count.index], "domain_name"), var.aws_route53_zone_id)}"
  # records = ["${lookup(local.sorted_domain_validation_options[count.index], "resource_record_value")}"]

  name    = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_type")}"
  zone_id = "${lookup(var.cert_subject_alternative_name_to_zone_id_map, lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "domain_name"), var.aws_route53_zone_id)}"
  records = ["${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_value")}"]
  ttl     = "${var.validation_record_ttl}"
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.*.fqdn}"]
}
