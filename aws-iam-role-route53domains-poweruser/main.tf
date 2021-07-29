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

resource "aws_iam_role" "route53domains-poweruser" {
  name               = var.role_name
  path               = var.iam_path
  assume_role_policy = module.assume_role_policy.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "route53domains-fullaccess" {
  role       = aws_iam_role.route53domains-poweruser.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53DomainsFullAccess"
}

resource "aws_iam_role_policy_attachment" "route53-readonly" {
  role       = aws_iam_role.route53domains-poweruser.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53ReadOnlyAccess"
}
