# The root role is used by the argo CD server to interact with all other clusters.
# Typically, this should only be used by the EKS cluster that implements Argo.
# All other clusters will use the argo_child_role.tf to make roles that allow this one to assume it.
locals {
  eks_oidc_issuer_url = replace(module.cluster.cluster_oidc_issuer_url, "https://", "")
  argo_root_role_name = "argo_root_${local.namespace}"
}

data "aws_iam_policy_document" "cluster_assume_role" {
  count = var.addons.enable_argocd ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.eks_oidc_issuer_url}"]
    }

    condition {
      test     = "ForAllValues:StringLike"
      variable = "${local.eks_oidc_issuer_url}:sub"
      values = [
        "system:serviceaccount:argocd:argocd-server",
        "system:serviceaccount:argocd:argocd-application-controller",
        "system:serviceaccount:argocd:argocd-applicationset-controller",
        "system:serviceaccount:argocd:argocd-notifications-controller",
        "system:serviceaccount:core-platform-rdev:*",
        "system:serviceaccount:core-platform-staging:*",
        "system:serviceaccount:core-platform-prod:*",
      ]
    }
  }
}

resource "aws_iam_role" "argocd_sa_role" {
  count = var.addons.enable_argocd ? 1 : 0

  name               = local.argo_root_role_name
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role[0].json
}


data "aws_iam_policy_document" "assume_role_to_argo_child" {
  count = var.addons.enable_argocd ? 1 : 0

  statement {
    actions = [
      "sts:AssumeRole"
    ]
    resources = ["arn:aws:iam::*:role/${local.argo_child_role_name_prefix}*"]
    effect    = "Allow"

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = [var.aws_org_id]
    }
  }
}

resource "aws_iam_role_policy" "assume_role_to_argo_child" {
  count = var.addons.enable_argocd ? 1 : 0

  role        = aws_iam_role.argocd_sa_role[0].name
  name_prefix = "assume_role_to_argo_child_${local.namespace}"
  policy      = data.aws_iam_policy_document.assume_role_to_argo_child[0].json
}
