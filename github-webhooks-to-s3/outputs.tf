output "bucket" {
  value       = module.bucket.id
  description = "S3 bucket that Github webhooks are streamed into"
}
