data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "current" {
  name = var.cluster_name
}

locals {
  oidc_id = replace(data.aws_eks_cluster.current.identity[0].oidc[0].issuer, "https://", "")
}

resource "aws_sqs_queue" "sqs_queue" {
  name = var.sqs_name
  tags = var.tags
}

data "aws_iam_policy_document" "oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_id}:sub"
      values   = ["system:serviceaccount:argo-events:argo-events-operator-sa"]
    }

    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_id}"
      ]
    }
  }
}

resource "aws_iam_role" "sqs_queue_iam_role" {
  name = "${var.sqs_name}-role"

  assume_role_policy = data.aws_iam_policy_document.oidc.json
  tags               = var.tags
}

resource "aws_iam_policy" "sqs_queue_policy" {
  name        = "${var.sqs_name}-policy"
  description = "IAM policy to allow the service account to access the SQS queue."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Effect   = "Allow"
        Resource = aws_sqs_queue.sqs_queue.arn
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sqs_policy_attachment" {
  role       = aws_iam_role.sqs_queue_iam_role.name
  policy_arn = aws_iam_policy.sqs_queue_policy.arn
}

resource "aws_sqs_queue_redrive_allow_policy" "this" {
  count = var.redrive_allow_policy != null ? 1 : 0

  queue_url = aws_sqs_queue.sqs_queue.id

  redrive_allow_policy = jsonencode({
    redrivePermission = var.redrive_allow_policy.redrive_permission
    sourceQueueArns   = var.redrive_allow_policy.source_queue_arns
  })
}
