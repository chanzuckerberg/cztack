resource "aws_iam_role" "readonly" {
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

resource "aws_iam_role_policy_attachment" "readonly" {
  role       = "${aws_iam_role.readonly.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_policy" "secrets" {
  name = "${var.role_name}-chamber-read"
  path = "${var.iam_path}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ssm:Describe*",
                "ssm:Get*",
                "ssm:List*",
                "kms:Decrypt"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF

  lifecycle {
    ignore_changes = ["name"]
  }
}
