resource "aws_iam_role" "poweruser" {
  name = "${var.role_name}"
  path = "${var.iam_path}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.source_account_id}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
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
      "iam:CreateRole",
      "iam:DeleteInstanceProfile",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:GetInstanceProfile",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole*",
      "iam:ListAttachedRolePolicies",
      "iam:ListEntitiesForPolicy",
      "iam:ListInstanceProfilesForRole",
      "iam:ListRole",
      "iam:ListRolePolicies",
      "iam:PassRole",
      "iam:PutRole",
      "iam:PutRolePolicy",
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
