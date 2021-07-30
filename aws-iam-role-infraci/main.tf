locals {
  tags = {
    env     = var.env
    owner   = var.owner
    service = var.service
    project = var.project
  }
}

data "aws_iam_policy_document" "assume-role" {
  dynamic "statement" {
    for_each = var.source_account_ids
    content {
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${statement.value}:root"]
      }
      actions = ["sts:AssumeRole"]
    }
  }

  dynamic "statement" {
    for_each = compact([var.saml_idp_arn])
    content {
      principals {
        type        = "Federated"
        identifiers = [statement.value]
      }

      actions = ["sts:AssumeRoleWithSAML"]

      condition {
        test     = "StringEquals"
        variable = "SAML:aud"
        values   = ["https://signin.aws.amazon.com/saml"]
      }
    }
  }
}

resource "aws_iam_role" "infraci" {
  name               = var.role_name
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "infraci" {
  role       = aws_iam_role.infraci.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
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

  statement {
    sid = "servicediscovery"

    actions = [
      "servicediscovery:GetService",
      "servicediscovery:GetNamespace",
    ]

    resources = ["*"]
  }

  statement {
    sid       = "secretsmanager"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "secretsmanager:ResourceTag/allowCI"
      values   = ["true"]
    }
  }

  dynamic "statement" {

    for_each = var.terraform_state_lock_dynamodb_arns


    content {
      sid = "statefileaccess${statement.key}"

      actions = [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem",
      ]

      resources = [statement.value]
    }
  }
}

resource "aws_iam_policy" "secrets" {
  name   = "${var.role_name}-secrets-reader"
  path   = var.iam_path
  policy = data.aws_iam_policy_document.secrets.json

  lifecycle {
    ignore_changes = [name]
  }
}

resource "aws_iam_role_policy_attachment" "secrets" {
  role       = aws_iam_role.infraci.name
  policy_arn = aws_iam_policy.secrets.arn
}
