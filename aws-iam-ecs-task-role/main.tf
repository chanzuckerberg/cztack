resource "aws_iam_role" "role" {
  name        = "${var.project}-${var.env}-${var.service}"
  description = "Task role for ${var.service} task in ${var.project}-${var.env}. Owned by ${var.owner}."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "policy" {
  name = "${var.project}-${var.env}-${var.service}"
  role = "${aws_iam_role.role.id}"

  policy = "${var.policy}"
}
