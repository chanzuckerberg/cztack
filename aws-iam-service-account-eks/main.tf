locals {
  iam_path             = coalesce(var.iam_path, "/${var.eks_cluster.cluster_id}/")
  oidc_provider_url    = replace(var.eks_cluster.cluster_oidc_issuer_url, "https://", "")
  service_account_name = coalesce(var.service_account_name, "*")
  name                 = coalesce(var.service_account_name, "${var.tags.service}-${var.tags.env}-${var.tags.project}")
}

data "aws_iam_policy_document" "assume-role" {
  statement {
    principals {
      type        = "Federated"
      identifiers = [var.eks_cluster.oidc_provider_arn]
    }

    condition {
      test     = "StringLike"
      variable = "${local.oidc_provider_url}:sub"
      values   = ["system:serviceaccount:${var.k8s_namespace}:${local.service_account_name}"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]
  }
}

resource "aws_iam_role" "role" {
  name                 = local.name
  description          = "Service account role for ${local.name}"
  assume_role_policy   = data.aws_iam_policy_document.assume-role.json
  path                 = local.iam_path
  max_session_duration = var.max_session_duration
  permissions_boundary = var.role_permissions_boundary_arn
}

resource "kubernetes_service_account" "service_account" {
  metadata {
    name      = local.name
    namespace = var.k8s_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.role.arn
    }
  }
  automount_service_account_token = true
}
