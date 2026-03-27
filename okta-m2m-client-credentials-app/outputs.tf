output "authz_server" {
  description = "The Okta auth server"
  value       = okta_auth_server.auth_server
}

output "app" {
  description = "The Okta OAuth application"
  value = {
    id        = okta_app_oauth.app.id
    name      = okta_app_oauth.app.name
    client_id = okta_app_oauth.app.client_id
  }
}

output "kms_key_arn" {
  description = "The ARN of the KMS key used for signing"
  value       = var.create_kms_key ? aws_kms_key.service_user[0].arn : null
}
