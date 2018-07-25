resource "aws_iam_role" "readonly" {
  name = "readonly"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${var.source_account}:root"
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
  name = "chamber-read"
  path = "/"

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
}
