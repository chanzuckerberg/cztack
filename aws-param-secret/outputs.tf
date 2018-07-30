output "value" {
  value = "${data.aws_ssm_parameter.secret.value}"
}
