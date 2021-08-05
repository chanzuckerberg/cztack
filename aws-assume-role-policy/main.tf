data "aws_iam_policy_document" "assume-role" {
  dynamic "statement" {
    for_each = var.source_account_ids
    content {
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${statement.value}:root"]
      }
      actions = ["sts:AssumeRole", "sts:TagSession"]
    }
  }

  dynamic "statement" {
    for_each = var.saml_idp_arns

    content {
      principals {
        type        = "Federated"
        identifiers = [statement.value]
      }

      actions = ["sts:AssumeRoleWithSAML", "sts:TagSession"]

      condition {
        test     = "StringEquals"
        variable = "SAML:aud"
        values   = ["https://signin.aws.amazon.com/saml"]
      }
    }
  }

  dynamic "statement" {
    for_each = var.oidc
    iterator = oidc

    content {
      principals {
        type        = "Federated"
        identifiers = [oidc.value["idp_arn"]]
      }

      actions = ["sts:AssumeRoleWithWebIdentity", "sts:TagSession"]
      condition {
        test     = "StringEquals"
        variable = "${oidc.value["provider"]}:aud"
        values   = oidc.value["client_ids"]
      }
    }
  }

  dynamic "statement" {
    for_each = var.ci_manager
    content {
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.ci_manager.account_id}:root"]
      }
      actions = ["sts:AssumeRole"]
      effect  = "Allow"
      condition {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = [var.sts_external_id]
      }
    }
  }
}

statement {
    sid = "ExternalPartyAssume"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.caller_account_id}:root"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.sts_external_id]
    }
  }