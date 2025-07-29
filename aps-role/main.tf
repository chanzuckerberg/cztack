data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_eks_cluster" "current" {
  name = var.cluster_name
}

locals {
  oidc_id = replace(data.aws_eks_cluster.current.identity[0].oidc[0].issuer, "https://", "")
}

data "aws_iam_policy_document" "oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_id}:sub"
      values   = ["system:serviceaccount:grafana:grafana-sa"]
    }

    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_id}"
      ]
    }
  }
}

resource "aws_iam_role" "amp" {
  name               = "${var.cluster_name}-grafana-amp-role"
  assume_role_policy = data.aws_iam_policy_document.oidc.json
  tags               = var.tags
}

resource "aws_iam_policy" "amp" {
  name        = "${var.cluster_name}-grafana-amp-policy"
  path        = "/"
  description = "Allows EKS deployed Grafana to access AMP"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "aps:QueryMetrics",
          "aps:GetSeries",
          "aps:GetLabels",
          "aps:GetMetricMetadata"
        ],
        Resource : ["*"]
      }
    ]
  })
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "amp-policy-attachment" {
  role       = aws_iam_role.amp.name
  policy_arn = aws_iam_policy.amp.arn
}
