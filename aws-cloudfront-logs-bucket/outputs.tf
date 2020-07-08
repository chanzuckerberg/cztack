// HACK(el): we do this to hint TF dependency graph since modules can't depend_on
output "name" {
  value = module.aws-s3-private-bucket.name
}

output "domain_name" {
  value = module.aws-s3-private-bucket.domain_name
}

output "arn" {
  value = module.aws-s3-private-bucket.arn
}

output "id" {
  value = module.aws-s3-private-bucket.id
}
