output "ca_public_key" {
  value = bless_ca.bless.public_key
}

output "lambda_arn" {
  value = aws_lambda_function.bless.arn
}
