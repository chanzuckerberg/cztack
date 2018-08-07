resource "aws_iam_role" "role" {
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
