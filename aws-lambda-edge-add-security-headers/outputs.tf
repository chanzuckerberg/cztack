output "qualified_arn" {
  value       = module.lambda.qualified_arn
  description = "The qualified arn (version number included) of the latest published lambda version."
}
