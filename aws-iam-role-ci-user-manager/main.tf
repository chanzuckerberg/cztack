data "aws_caller_identity" "current" {}

module assume_role_policy {
  source             = "../aws-assume-role-policy"
  source_account_ids = toset([data.aws_caller_identity.current.account_id])
  env                = var.env
  owner              = var.owner
  service            = var.service
  project            = var.project
  ci_manager         = {
    sts_external_id = var.sts_external_id
    caller_account_id = var.caller_account_id
  }
}

resource "aws_iam_role" "ci-manager" {
  name               = "ci-manager"
  assume_role_policy = module.assume_role_policy.json

  tags = {
    managedBy = "terraform"
    env       = var.env
    owner     = var.owner
    service   = var.service
    project   = var.project
  }
}

data "aws_iam_policy_document" "ci-manager" {
  statement {
    sid = "ManageCIUsers"

    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:GetAccessKeyLastUsed",
      "iam:GetUser",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
    ]

    resources = ["arn:aws:iam::*:user/ci/*"] // all users with ci in their path
  }

  statement {
    sid = "ListUsers"

    actions = [
      "iam:ListUsers",
    ]

    resources = ["*"] // list all users to be able to use the console
  }
}

resource "aws_iam_role_policy" "ci-manager" {
  name   = "ci-manager"
  role   = aws_iam_role.ci-manager.id
  policy = data.aws_iam_policy_document.ci-manager.json
}