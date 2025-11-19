output "kms_key" {
  description = "The KMS key used for signing"
  value = {
    arn = aws_kms_key.service_user.arn
    id  = aws_kms_key.service_user.key_id
  }
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

output "oidc_admin_scope_name" {
  description = "The OIDC scope for cluster-admin"
  value       = okta_auth_server_scope.admin_scope.name
}

output "oidc_readonly_scope_name" {
  description = "The OIDC scope for cluster-readonly"
  value       = okta_auth_server_scope.readonly_scope.name
}
