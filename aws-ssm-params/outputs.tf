output "values" {
  description = "Map from keys to corresponding values stored in the SSM Parameter Store."
  value       = { for k, v in data.aws_ssm_parameter.secret : k => v.value }
}
