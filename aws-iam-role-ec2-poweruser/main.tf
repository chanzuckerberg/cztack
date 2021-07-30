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
  env                = var.env
  owner              = var.owner
  service            = var.service
  project            = var.project
}

resource "aws_iam_role" "ec2-poweruser" {
  name               = var.role_name
  path               = var.iam_path
  assume_role_policy = module.assume_role_policy.json
  tags               = local.tags
}

data "aws_iam_policy_document" "ec2" {
  statement {
    sid       = "ec2"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2" {
  count = var.default_iam_policy ? 1 : 0

  name        = "${var.role_name}-ec2"
  description = "Provides full access to the ec2 api"
  path        = var.iam_path
  policy      = data.aws_iam_policy_document.ec2.json
}

resource "aws_iam_role_policy_attachment" "ec2" {
  count = var.default_iam_policy ? 1 : 0

  role       = aws_iam_role.ec2-poweruser.name
  policy_arn = aws_iam_policy.ec2[0].arn
}
