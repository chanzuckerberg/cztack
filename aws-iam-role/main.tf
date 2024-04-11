locals {
  tags = {
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
    managedBy = "terraform"
  }
}

module "assume_role_policy" {
  source             = "../aws-assume-role-policy"
  source_account_ids = var.source_account_ids
  saml_idp_arns      = toset(flatten([for idp in var.saml_idps: idp.saml_idp_arns]))
  oidc               = var.oidc
  env                = var.env
  owner              = var.owner
  service            = var.service
  project            = var.project
}


resource "aws_iam_role" "role" {
  name               = var.role_name
  description        = var.role_description
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  max_session_duration = var.max_session_duration

  tags = local.tags
}

resource "aws_iam_role_policy" "policy" {
  for_each = { for policy in var.inline_policies : policy.name => policy }
  name     = each.value.name
  role     = aws_iam_role.role.id
  policy   = each.value.policy
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each   = var.attached_policies_names_arns
  role       = aws_iam_role.role.id
  policy_arn = each.value
}
