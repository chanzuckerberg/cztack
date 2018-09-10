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

resource "aws_iam_policy" "policy" {
  count  = "${var.policy_text != "" ? 1 : 0 }"
  name   = "${var.project}-${var.env}-${var.service}"
  policy = "${var.policy_text}"
}

resource "aws_iam_role_policy_attachment" "attachment" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${var.policy_text != "" ? aws_iam_policy.policy.arn : var.policy_arn}"
}
