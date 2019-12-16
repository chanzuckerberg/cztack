data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "EnableLambdaAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda" {
  statement {
    sid = "kms"

    actions = [
      "kms:GenerateRandom",
      "kms:Decrypt",
    ]

    resources = ["${aws_kms_key.bless.arn}"]
  }

  statement {
    sid       = "describekey"
    actions   = ["kms:DescribeKey"]
    resources = ["${aws_kms_key.bless_kms_auth.arn}"]
  }

  statement {
    sid = "kmsauth"

    actions = [
      "kms:Decrypt",
    ]

    resources = ["${aws_kms_key.bless_kms_auth.arn}"]

    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:to"
      values   = ["${local.name}"]
    }
  }

  statement {
    sid = "listgroups"

    actions = [
      "iam:ListGroupsForUser",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "bless" {
  name_prefix        = "${local.name}-"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = local.tags
}

resource "aws_iam_role_policy" "lambda" {
  name   = "${local.name}-lambda"
  role   = aws_iam_role.bless.id
  policy = data.aws_iam_policy_document.lambda.json
}

module "logs_policy" {
  source    = "../aws-iam-policy-cwlogs"
  role_name = aws_iam_role.bless.name
  iam_path  = var.iam_path
}
