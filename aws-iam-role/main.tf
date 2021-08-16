locals {
  tags = {
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
    managedBy = "terraform"
  }
  all_saml_idps = concat(
    var.saml_idps,
    // NOTE(el): by default, these assume SAML assertions signed for AWS specifically.
    [for aws_saml_idp_arn in var.saml_idp_arns : {
      saml_idp_arn = [aws_saml_idp_arn],
      saml_aud     = ["https://signin.aws.amazon.com/saml"]
  }])
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    dynamic "principals" {
      for_each = var.principals
      content {
        type        = principals.value.type
        identifiers = principals.value.identifiers
      }
    }
    actions = ["sts:AssumeRole"]
  }

  dynamic "statement" {
    for_each = local.all_saml_idps
    content {
      principals {
        type        = "Federated"
        identifiers = statement.value.saml_idp_arns
      }

      actions = ["sts:AssumeRoleWithSAML"]

      condition {
        test     = "StringEquals"
        variable = "SAML:aud"
        values   = statement.value.saml_auds
      }
    }
  }
}

resource "aws_iam_role" "role" {
  name               = var.role_name
  description        = var.role_description
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  max_session_duration = var.max_session_duration

  tags = local.tags
}

resource "aws_iam_role_policy" "policy" {
  for_each = { for policy in var.inline_policies : policy.name => policy }
  name     = each.value.name
  role     = aws_iam_role.role.id
  policy   = each.value.policy
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each   = var.attached_policies_names_arns
  role       = aws_iam_role.role.id
  policy_arn = each.value
}
