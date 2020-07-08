// HACK(el): we do this to hint TF dependency graph since modules can't depend_on
output "name" {
  value = var.bucket_name
}

output "domain_name" {
  value = aws-cloudfront-logs-bucket.aws_s3_bucket.bucket.bucket_domain_name
}

output "arn" {
  value = aws-cloudfront-logs-bucket.aws_s3_bucket.bucket.arn
}

output "id" {
  value = aws-cloudfront-logs-bucket.aws_s3_bucket.bucket.id
}
