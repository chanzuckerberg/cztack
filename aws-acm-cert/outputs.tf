output "arn" {
  value = "${aws_acm_certificate.cert.arn}"
}

output "id" {
  value = "${aws_acm_certificate.cert.id}"
}

output "domain_validation_options" {
  value = ["${aws_acm_certificate.cert.domain_validation_options}"]
}