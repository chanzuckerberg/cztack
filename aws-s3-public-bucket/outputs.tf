output "name" {
  value       = local.bucket_name
  description = "Name of this public bucket. It should have `public` in its name"
}

output "domain_name" {
  value       = aws_s3_bucket.bucket.bucket_domain_name
  description = "Domain where you host the public bucket"
}

output "arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "Public bucket ARN"
}

output "id" {
  value       = aws_s3_bucket.bucket.id
  description = "Public Bucket ID"
}
