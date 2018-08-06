resource "aws_iam_role" "security-audit" {
  name = "${var.role_name}"
  path = "${var.iam_path}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${var.source_account_id}:root"
    },
    "Action": "sts:AssumeRole"
  }
}
EOF
}

resource "aws_iam_role_policy_attachment" "security-audit" {
  role       = "${aws_iam_role.security-audit.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
