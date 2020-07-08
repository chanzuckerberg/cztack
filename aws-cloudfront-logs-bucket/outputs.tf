// HACK(el): we do this to hint TF dependency graph since modules can't depend_on
output "name" {
  value = module.aws-cloudfront-logs-bucket.name
}

output "domain_name" {
  value = module.aws-cloudfront-logs-bucket.domain_name
}

output "arn" {
  value = module.aws-cloudfront-logs-bucket.arn
}

output "id" {
  value = module.aws-cloudfront-logs-bucket.id
}
