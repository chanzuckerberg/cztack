resource "aws_kms_key" "service_user" {
  count = var.jwks == null ? 1 : 0

  description              = local.label
  key_usage                = "SIGN_VERIFY"
  customer_master_key_spec = "RSA_4096"
}

resource "aws_kms_alias" "service_user" {
  count = var.jwks == null ? 1 : 0

  name_prefix   = "alias/${local.label}"
  target_key_id = aws_kms_key.service_user[0].key_id
}

data "aws_kms_public_key" "service_user" {
  count = var.jwks == null ? 1 : 0

  key_id = aws_kms_key.service_user[0].key_id
}

data "jwks_from_key" "jwks" {
  count = var.jwks == null ? 1 : 0

  key = data.aws_kms_public_key.service_user[0].public_key_pem
  kid = aws_kms_key.service_user[0].key_id
}

locals {
  label = var.label != "" ? var.label : "${var.tags.project}-${var.tags.env}-${var.tags.service}-okta-m2m-service-account"
  
  # Use provided JWKS values if available, otherwise use KMS-generated values
  jwks = var.jwks != null ? var.jwks : jsondecode(data.jwks_from_key.jwks[0].jwks)
}

resource "okta_app_oauth" "app" {
  label                      = local.label
  type                       = "service"
  grant_types                = ["client_credentials"]
  redirect_uris              = []
  login_uri                  = ""
  omit_secret                = false
  response_types             = ["token"]
  login_mode                 = "DISABLED"
  login_scopes               = []
  token_endpoint_auth_method = "private_key_jwt"

  jwks {
    kid = local.jwks.kid
    kty = local.jwks.kty
    e   = local.jwks.e
    n   = local.jwks.n
  }
}

resource "okta_auth_server" "auth_server" {
  // The value here dictates the "aud" claim in the JWT token.
  // For Kubernetes, the "aud" claim has to match the OIDC identity provider configuration.
  // When they do a lookup for your token they have to look up the auth provider by the aud value from the token
  // if it doesn't match the token can't be verified.
  // References:
  // - https://github.com/kubernetes/kubernetes/issues/71162
  // - https://github.com/kubernetes/kubernetes/pull/123165/files
  audiences = [local.label]

  description = "Auth server for ${local.label}"
  name        = local.label
  issuer_mode = "ORG_URL"
}

resource "okta_auth_server_scope" "scopes" {
  for_each = var.scopes

  auth_server_id   = okta_auth_server.auth_server.id
  name             = each.key
  metadata_publish = each.value.metadata_publish
  consent          = each.value.consent
}

resource "okta_auth_server_claim" "groups_scope_claim" {
  auth_server_id = okta_auth_server.auth_server.id
  name           = "groups"
  value          = "access.scope"
  claim_type     = "RESOURCE"
}

resource "okta_auth_server_policy" "policy" {
  auth_server_id = okta_auth_server.auth_server.id
  priority       = 1
  name           = "Service account"
  description    = "Only allow the service account's credentials access to this application."
  client_whitelist = [
    okta_app_oauth.app.id,
  ]
}

resource "okta_auth_server_policy_rule" "rule" {
  auth_server_id       = okta_auth_server.auth_server.id
  policy_id            = okta_auth_server_policy.policy.id
  name                 = "Service account client credentials only"
  priority             = 1
  scope_whitelist      = [for scope in okta_auth_server_scope.scopes : scope.name]
  grant_type_whitelist = ["client_credentials"]
  group_whitelist      = ["EVERYONE"]
}
