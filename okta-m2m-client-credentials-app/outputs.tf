output "kms_key" {
  description = "The KMS key used for signing (null if JWKS values were provided)"
  value = var.jwks == null ? {
    arn = aws_kms_key.service_user[0].arn
    id  = aws_kms_key.service_user[0].key_id
  } : null
}

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