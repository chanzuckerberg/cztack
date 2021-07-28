
data "aws_iam_policy_document" "assume-role" {
  dynamic "statement" {
    for_each = compact([var.source_account_id])
    content {
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${statement.value}:root"]
      }
      actions = ["sts:AssumeRole", "sts:TagSession"]
    }
  }

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

}