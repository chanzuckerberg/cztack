locals {
  tags = {
    env     = var.env
    owner   = var.owner
    service = var.service
    project = var.project
  }
}

module "assume_role_policy" {
  source = "../aws-assume-role-policy"
  source_account_ids = var.source_account_ids
  saml_idp_arns = var.saml_idp_arns
  oidc = var.oidc
}

resource "aws_iam_role" "readonly" {
  name               = var.role_name
  path               = var.iam_path
  assume_role_policy = module.assume_role_policy.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "readonly" {
  role       = aws_iam_role.readonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

data "aws_iam_policy_document" "secrets" {
  statement {
    actions = [
      "kms:Decrypt",
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "secrets" {
  count = var.authorize_read_secrets ? 1 : 0

  name   = "secrets"
  role   = aws_iam_role.readonly.name
  policy = data.aws_iam_policy_document.secrets.json
}
