locals {
  all_regions_enabled  = "${length(var.authorized_regions) == 0 ? 1 : 0}"
  all_regions_disabled = "${1 - local.all_regions_enabled}"
}

data "aws_iam_policy_document" "assume-role" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.source_account_id}:root"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "poweruser" {
  name               = "${var.role_name}"
  path               = "${var.iam_path}"
  assume_role_policy = "${data.aws_iam_policy_document.assume-role.json}"
}

resource "aws_iam_role_policy_attachment" "poweruser" {
  role       = "${aws_iam_role.poweruser.name}"
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
      "iam:GetInstanceProfile",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListEntitiesForPolicy",
      "iam:ListInstanceProfiles",
      "iam:ListInstanceProfilesForRole",
      "iam:ListPolicies",
      "iam:ListPolicyVersions",
      "iam:ListRolePolicies",
      "iam:ListRoles",
      "iam:ListServerCertificates",
      "iam:PassRole",
      "iam:PutRole",
      "iam:PutRolePolicy",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:TagRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRole",
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
  name        = "${var.role_name}-misc"
  path        = "${var.iam_path}"
  description = "Extra permissions we're granting that PowerUserAccess lacks"
  policy      = "${data.aws_iam_policy_document.misc.json}"
}

resource "aws_iam_role_policy_attachment" "misc" {
  role       = "${aws_iam_role.poweruser.name}"
  policy_arn = "${aws_iam_policy.misc.arn}"
}
