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
      actions = ["sts:AssumeRole", "sts:TagSession"]
    }
  }

  dynamic "statement" {
    for_each = compact([var.saml_idp_arn])
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

resource "aws_iam_role" "poweruser" {
  name                 = var.role_name
  path                 = var.iam_path
  assume_role_policy   = data.aws_iam_policy_document.assume-role.json
  max_session_duration = var.max_session_duration
  tags                 = local.tags
}

resource "aws_iam_role_policy_attachment" "poweruser" {
  role       = aws_iam_role.poweruser.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# These are extra permissions we're adding that
# the PowerUserAcess policy does not have
data "aws_iam_policy_document" "misc" {
  statement {
    sid = "misc"

    actions = [
      "iam:AddRoleToInstanceProfile",
      "iam:AttachRolePolicy",
      "iam:CreateInstanceProfile",
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:CreateRole",
      "iam:DeleteInstanceProfile",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:GetInstanceProfile",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:GetServiceLastAccessedDetails",
      "iam:GetUser",
      "iam:GetUserPolicy",
      "iam:ListAccessKeys",
      "iam:ListAccountAliases",
      "iam:ListAttachedGroupPolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListAttachedUserPolicies",
      "iam:ListEntitiesForPolicy",
      "iam:ListGroupPolicies",
      "iam:ListGroups",
      "iam:ListGroupsForUser",
      "iam:ListInstanceProfiles",
      "iam:ListInstanceProfilesForRole",
      "iam:ListMFADevices",
      "iam:ListOpenIDConnectProviders",
      "iam:ListPolicies",
      "iam:ListPoliciesGrantingServiceAccess",
      "iam:ListPolicyVersions",
      "iam:ListRolePolicies",
      "iam:ListRoles",
      "iam:ListRoleTags",
      "iam:ListSAMLProviders",
      "iam:ListServerCertificates",
      "iam:ListServiceSpecificCredentials",
      "iam:ListSigningCertificates",
      "iam:ListSSHPublicKeys",
      "iam:ListUserPolicies",
      "iam:ListUsers",
      "iam:ListUserTags",
      "iam:ListVirtualMFADevices",
      "iam:PassRole",
      "iam:PutRole",
      "iam:PutRolePolicy",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:TagRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription",
    ]

    resources = ["*"]
  }

  # Explicit deny of these to retain aws account invariants
  statement {
    effect = "Deny"

    actions = [
      "iam:CreateUser",
      "iam:DeleteUser",
      "iam:CreateGroup",
      "iam:DeleteGroup",
      "route53domains:RegisterDomain",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "misc" {
  count = var.authorize_iam ? 1 : 0

  name        = "${var.role_name}-misc"
  path        = var.iam_path
  description = "Extra permissions we're granting that PowerUserAccess lacks"
  policy      = data.aws_iam_policy_document.misc.json
}

resource "aws_iam_role_policy_attachment" "misc" {
  count = var.authorize_iam ? 1 : 0

  role       = aws_iam_role.poweruser.name
  policy_arn = aws_iam_policy.misc[count.index].arn
}
