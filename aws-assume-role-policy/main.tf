data "aws_iam_policy_document" "assume-role" {
  # Allow the root of these accounts to assume role
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
  # Allow Assuming the role with a list of SAML ARNs
  dynamic "statement" {
    for_each = toset(var.saml_idp_arns)
    content {
      principals {
        type        = "Federated"
        identifiers = each.key
      }
      actions = ["sts:AssumeRoleWithSAML", "sts:TagSession"]
      condition {
        test     = "StringEquals"
        variable = "SAML:aud"
        values   = ["https://signin.aws.amazon.com/saml"]
      }
    }
  }
  # Allow Assuming the role with a list of OIDC Configurations
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
