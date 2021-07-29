locals {
  tags = {
    env     = var.env
    owner   = var.owner
    service = var.service
    project = var.project
  }
}

module "assume_role_policy" {
  source             = "../aws-assume-role-policy"
  source_account_ids = var.source_account_ids
  saml_idp_arns      = var.saml_idp_arns
  oidc               = var.oidc
}


resource "aws_iam_role" "role" {
  name                 = var.role_name
  path                 = var.iam_path
  assume_role_policy   = module.assume_role_policy.json
  tags                 = local.tags
  max_session_duration = var.max_session_duration

  # We have to force detach policies in order to recreate roles.
  # The other option would be to use name_prefix and create_before_destroy, but that
  # doesn't work if you want a role with a stable, memorable name.
  force_detach_policies = true
}
