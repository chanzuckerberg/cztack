// HACK(el): we do this to hint TF dependency graph since modules can't depend_on
output "name" {
  value = var.bucket_name
}

output "domain_name" {
  value = aws_s3_bucket.bucket.bucket_domain_name
}

output "arn" {
  value = aws_s3_bucket.bucket.arn
}

output "id" {
  value = aws_s3_bucket.bucket.id
}

output "bucket_kms_encryption_key_arn" {
  value = one(aws_kms_key.bucket_kms_key[*].arn)
}