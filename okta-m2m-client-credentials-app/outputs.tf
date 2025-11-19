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