output "ca_public_key" {
  value = "${bless_ca.bless.public_key}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.bless.arn}"
}

output "kmsauth_id" {
  value = "${aws_kms_key.bless_kms_auth.arn}"
}
