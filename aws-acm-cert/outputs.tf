output "arn" {
  value = "${aws_acm_certificate.cert.arn}"
}

output "id" {
  value = "${aws_acm_certificate.cert.id}"
}
