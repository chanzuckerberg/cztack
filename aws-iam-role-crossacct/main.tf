data "aws_iam_policy_document" "assume-role" {
  dynamic "statement" {
    for_each = compact([var.source_account_id])
    content {
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.source_account_id}:root"]
      }
      actions = ["sts:AssumeRole"]
    }
  }

  dynamic "statement" {
    for_each = compact([var.saml_idp_arn])
    content {
      principals {
        type        = "Federated"
        identifiers = ["${var.saml_idp_arn}"]
      }

      actions = ["sts:AssumeRoleWithSAML"]

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
        identifiers = [oidc.idp_arn]
      }

      actions = ["sts:AssumeRoleWithWebIdentity"]
      condition {
        test     = "StringEquals"
        variable = "${oidc.provider}:aud"
        values   = oidc.client_ids
      }
    }
  }

}

resource "aws_iam_role" "role" {
  name               = var.role_name
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.assume-role.json

  # We have to force detach policies in order to recreate roles.
  # The other option would be to use name_prefix and create_before_destroy, but that
  # doesn't work if you want a role with a stable, memorable name.
  force_detach_policies = true
}
