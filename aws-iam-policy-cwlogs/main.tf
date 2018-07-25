resource "aws_iam_policy" "logs-policy" {
  name_prefix = "${var.role_name}-logs-policy"
  description = "A terraform created policy for cloudwatch logs"
  path        = "${var.iam_path}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "attach-logs" {
  name       = "logs-attachment"
  roles      = ["${var.role_name}"]
  policy_arn = "${aws_iam_policy.logs-policy.arn}"
}
