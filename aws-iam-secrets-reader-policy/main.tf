# TODO KMS permissions
data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = var.secrets_arns
  }
}

resource "aws_iam_policy" "policy" {
  name_prefix = "${var.role_name}-secrets-policy"
  description = "A terraform created policy for reading secrets manager secrets."
  path        = var.iam_path
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_policy_attachment" "attach" {
  name       = "attachment"
  roles      = [var.role_name]
  policy_arn = aws_iam_policy.policy.arn
}
