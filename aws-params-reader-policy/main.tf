locals {
  resource_name = "${var.project}-${var.env}-${var.service}"
}

data "aws_caller_identity" "current" {}

data "aws_kms_alias" "parameter_store_key" {
  name = "alias/${var.parameter_store_key_alias}"
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:DescribeParameters",
    ]

    resources = ["arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${local.resource_name}/*"]
  }

  statement {
    actions   = ["kms:Decrypt"]
    resources = ["${data.aws_kms_alias.parameter_store_key.target_key_arn}"]
  }
}

resource "aws_iam_role_policy" "policy" {
  name   = "${local.resource_name}-parameter-policy"
  role   = "${var.role_name}"
  policy = "${data.aws_iam_policy_document.policy.json}"
}
