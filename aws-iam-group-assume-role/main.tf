locals {
  account_arns = "${formatlist("arn:aws:iam::%s:role/${var.target_role == "" ? var.group_name : var.target_role}", var.target_accounts)}"
}

resource "aws_iam_group" "assume-role" {
  name = "${var.group_name}"
  path = "${var.path}"
}

resource "aws_iam_group_membership" "assume-role" {
  name  = "${var.group_name}"
  users = ["${var.users}"]
  group = "${aws_iam_group.assume-role.name}"
}

resource "aws_iam_policy" "assume-role" {
  name        = "${var.group_name}"
  path        = "${var.path}"
  description = ""

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "assume0",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": ${jsonencode(local.account_arns)}
        }
    ]
}
POLICY
}

resource "aws_iam_group_policy_attachment" "assume-role" {
  policy_arn = "${aws_iam_policy.assume-role.arn}"
  group      = "${aws_iam_group.assume-role.name}"
}
