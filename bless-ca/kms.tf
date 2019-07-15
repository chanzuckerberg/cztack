data "aws_caller_identity" "current" {}

resource "aws_kms_key" "bless" {
  description             = "KMS key for ${local.name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = "${local.tags}"
}

resource "aws_kms_alias" "bless" {
  name          = "alias/${local.name}"
  target_key_id = "${aws_kms_key.bless.key_id}"
}

data "aws_iam_policy_document" "kmsauth" {
  statement {
    sid       = "Enable IAM user permissions"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"] # allows root + admins on the account to manage this key
    }
  }

  statement {
    sid       = "Enable user permissions"
    actions   = ["kms:Encrypt"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["${var.authorized_users}"] # allows users to state their identity through kmsauth
    }

    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:to"
      values   = ["${local.name}"]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:user_type"
      values   = ["user"]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:from"
      values   = ["$${aws:username}"]
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_kms_key" "bless_kms_auth" {
  description             = "KMS key for kmsauth for ${local.name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = "${data.aws_iam_policy_document.kmsauth.json}"

  tags = "${local.tags}"
}

resource "aws_kms_alias" "bless_kms_auth" {
  name          = "alias/${local.name}-kms-auth"
  target_key_id = "${aws_kms_key.bless_kms_auth.key_id}"
}
