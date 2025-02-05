output "client_id" {
  value = okta_app_oauth.idp_api.id
}

output "kms_id" {
  value = var.kms_key_id
}