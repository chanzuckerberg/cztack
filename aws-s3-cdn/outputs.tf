# HACK: hint the TF dependency graph since modules can't depend_on. Also the exact name
# external upload roles (shared-infra) must reference.
output "bucket_name" {
  value = var.bucket_name
}

output "bucket_arn" {
  value = module.bucket.arn
}

output "bucket_id" {
  value = module.bucket.id
}

output "bucket_domain_name" {
  value = module.bucket.domain_name
}

output "bucket_regional_domain_name" {
  value = local.origin_domain
}

output "cloudfront_domain_name" {
  value = try(aws_cloudfront_distribution.this[0].domain_name, null)
}

output "cloudfront_distribution_id" {
  value = try(aws_cloudfront_distribution.this[0].id, null)
}

output "cloudfront_distribution_arn" {
  value = try(aws_cloudfront_distribution.this[0].arn, null)
}

output "cloudfront_hosted_zone_id" {
  value = try(aws_cloudfront_distribution.this[0].hosted_zone_id, null)
}

output "boto_role_arn" {
  value = try(aws_iam_role.boto[0].arn, null)
}

output "boto_role_name" {
  value = try(aws_iam_role.boto[0].name, null)
}

output "csi_policy_arn" {
  value = try(aws_iam_policy.csi[0].arn, null)
}
