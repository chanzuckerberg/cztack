data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
# uses a key in core-platform-infra to generate credentials for this workspace
data "external" "jwks_info" {
  program = ["bash", "${path.module}/run.sh", path.module, data.aws_caller_identity.current.account_id, var.kms_key_id, data.aws_region.current.name]
}

resource "okta_app_oauth" "idp_api" {
  label                      = var.okta_configuration.label
  type                       = var.okta_configuration.type
  grant_types                = var.okta_configuration.grant_types
  response_types             = var.okta_configuration.response_types
  token_endpoint_auth_method = "private_key_jwt"
  pkce_required              = var.okta_configuration.pkce_required
  jwks {
    e   = data.external.jwks_info.result.e
    kty = data.external.jwks_info.result.kty
    kid = var.friendly_key_identifier
    n   = data.external.jwks_info.result.n
  }
}


module "params" {
  source  = "github.com/chanzuckerberg/cztack//aws-ssm-params-writer?ref=v0.63.3"
  project = var.tags.project
  env     = var.tags.env
  service = var.tags.service
  owner   = var.tags.owner

  parameters = {
    "client_id"     = okta_app_oauth.app.client_id
    "kms_key_id"    = var.kms_key_id
  }
}
