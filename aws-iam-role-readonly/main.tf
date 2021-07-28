locals {
  tags = {
    env     = var.env
    owner   = var.owner
    service = var.service
    project = var.project
  }
}

# module "assume_role_policy" {
#   source             = "../aws-assume-role-policy"
#   source_account_ids = var.source_account_ids
#   saml_idp_arns      = var.saml_idp_arns
#   oidc               = var.oidc
# }

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


resource "aws_iam_role" "readonly" {
  name               = var.role_name
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "readonly" {
  role       = aws_iam_role.readonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

data "aws_iam_policy_document" "secrets" {
  statement {
    actions = [
      "kms:Decrypt",
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "secrets" {
  count = var.authorize_read_secrets ? 1 : 0

  name   = "secrets"
  role   = aws_iam_role.readonly.name
  policy = data.aws_iam_policy_document.secrets.json
}
