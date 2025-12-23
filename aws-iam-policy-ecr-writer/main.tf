data "aws_iam_policy_document" "ecr-writer" {
  statement {
    sid = "PushToECR"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]

    resources = var.ecr_repository_arns
  }
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr-writer" {
  name_prefix = var.policy_name
  path        = var.policy_path
  policy      = data.aws_iam_policy_document.ecr-writer.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecr-writer" {
  count = var.role_name != null ? 1 : 0
  role  = var.role_name

  policy_arn = aws_iam_policy.ecr-writer.arn
}

resource "aws_iam_user_policy_attachment" "ecr-writer" {
  count = var.user_name != null ? 1 : 0
  user  = var.user_name

  policy_arn = aws_iam_policy.ecr-writer.arn
}
