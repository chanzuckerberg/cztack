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

resource "aws_iam_role" "ecs-poweruser" {
  name               = var.role_name
  path               = var.iam_path
  assume_role_policy = module.assume_role_policy.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "ecs-fullaccess" {
  role       = aws_iam_role.ecs-poweruser.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecr-poweruser" {
  role       = aws_iam_role.ecs-poweruser.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

data "aws_iam_policy_document" "secrets" {
  statement {
    sid = "ssm"

    actions = [
      "ssm:DescribeParameters",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]

    resources = ["*"]
  }

  statement {
    sid       = "kms"
    actions   = ["kms:Decrypt"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "secrets" {
  name        = "${var.role_name}-secrets"
  path        = var.iam_path
  description = "Provide access to the parameters of service ${var.role_name}"
  policy      = data.aws_iam_policy_document.secrets.json
}

resource "aws_iam_role_policy_attachment" "secrets" {
  role       = aws_iam_role.ecs-poweruser.name
  policy_arn = aws_iam_policy.secrets.arn
}
