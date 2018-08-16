locals {
  name = "ssh-${var.principal_name}"
}

resource "aws_iam_group" "group" {
  name = "${local.name}"
  path = "${var.iam_path}"
}

resource "aws_iam_group_membership" "group" {
  name  = "${local.name}"
  users = ["${var.users}"]
  group = "${aws_iam_group.group.name}"
}
