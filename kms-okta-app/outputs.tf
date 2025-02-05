# need to output the client_id, some details about the app like the label name

output "client_id" {
  value = okta_app_oauth.idp_api.id
}