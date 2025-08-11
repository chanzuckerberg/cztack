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

resource "aws_iam_role" "amg" {
  name               = var.role_name_override != null ? var.role_name_override : "${var.cluster_name}-grafana-amg-role"
  assume_role_policy = data.aws_iam_policy_document.oidc.json
  tags               = var.tags
}

resource "aws_iam_policy" "amg" {
  name       = var.role_name_override != null ? "${var.role_name_override}-amg-policy" : "${var.cluster_name}-grafana-amg-policy"
  path        = "/"
  description = "Allows EKS deployed Grafana to access AMG"
  policy      = var.role_policy_json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "amg-policy-attachment" {
  role       = aws_iam_role.amg.name
  policy_arn = aws_iam_policy.amg.arn
}
