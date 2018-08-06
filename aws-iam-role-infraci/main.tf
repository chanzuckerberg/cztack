resource "aws_iam_role" "infraci" {
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

resource "aws_iam_role_policy_attachment" "infraci" {
  role       = "${aws_iam_role.infraci.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_policy" "secrets" {
  name = "${var.role_name}-secrets-reader"
  path = "${var.iam_path}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "ssm",
        "Action": [
          "ssm:GetParameter",
          "ssm:GetParameterHistory",
          "ssm:GetParameters",
          "ssm:GetParametersByPath",
          "ssm:DescribeParameters"
        ],
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Sid": "kms",
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt"
        ],
        "Resource": "*"
      },
      {
        "Sid": "servicediscovery",
        "Effect": "Allow",
        "Action": [
          "servicediscovery:GetService",
          "servicediscovery:GetNamespace"
        ],
        "Resource": "*"
      }
    ]
}
EOF

  lifecycle {
    ignore_changes = ["name"]
  }
}

resource "aws_iam_role_policy_attachment" "secrets" {
  role       = "${aws_iam_role.infraci.name}"
  policy_arn = "${aws_iam_policy.secrets.arn}"
}
