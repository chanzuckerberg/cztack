output "arn" {
  value       = aws_acm_certificate.cert.arn
  description = "AWS ARN of the certificate"
}

output "id" {
  value       = aws_acm_certificate.cert.id
  description = "ID of the certificate"
}
