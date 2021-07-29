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
}

resource "aws_iam_role" "security-audit" {
  name               = var.role_name
  path               = var.iam_path
  assume_role_policy = module.assume_role_policy.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "security-audit" {
  role       = aws_iam_role.security-audit.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
