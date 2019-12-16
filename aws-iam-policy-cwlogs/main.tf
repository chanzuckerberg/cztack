data "aws_iam_policy_document" "logs-policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "logs-policy" {
  name_prefix = "${var.role_name}-logs-policy"
  description = "A terraform created policy for cloudwatch logs"
  path        = var.iam_path
  policy      = data.aws_iam_policy_document.logs-policy.json
}

resource "aws_iam_policy_attachment" "attach-logs" {
  name       = "logs-attachment"
  roles      = ["${var.role_name}"]
  policy_arn = aws_iam_policy.logs-policy.arn
}
