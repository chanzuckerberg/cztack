# The child role is assumed by the argo CD server
# By default, every cluster comes with a role that allows argo to assume it.
# If you are setting up a cluster for Argo to run on, use the argo_root_role.tf
locals {
  argo_child_role_name_prefix = "argo_child"
  argo_child_role_name        = "${local.argo_child_role_name_prefix}_${local.namespace}"
  trusted_root_argo_ids = [
    for k, v in var.addons.argocd_child_config.root_argo_aws_account_id_to_role :
    "arn:aws:iam::${k}:role/${v}"
  ]
}

data "aws_iam_policy_document" "child_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      # Allow the root role to assume the EKS child
      identifiers = local.trusted_root_argo_ids
    }
  }
}

resource "aws_iam_role" "child_assume_role" {
  name               = local.argo_child_role_name
  assume_role_policy = data.aws_iam_policy_document.child_assume_role.json
}

data "aws_iam_policy_document" "secrets_manager_rw" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:UntagResource",
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue",
      "secretsmanager:CreateSecret",
      "secretsmanager:TagResource",
      "secretsmanager:UpdateSecret",
      "secretsmanager:DeleteSecret"
    ]
    resources = ["arn:aws:secretsmanager:*:${data.aws_caller_identity.current.account_id}:secret:/argus/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:ListSecrets",
      "secretsmanager:BatchGetSecretValue",
    ]
    // secretsmanager is all or nothing, doesn't allow for prefix-based iam policies
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "child_secrets_rw" {
  role        = aws_iam_role.child_assume_role.name
  name_prefix = "secrets_rw_${local.namespace}"
  policy      = data.aws_iam_policy_document.secrets_manager_rw.json
}
