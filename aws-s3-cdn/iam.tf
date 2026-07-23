locals {
  boto_prefix     = try(var.boto.prefix, null)
  boto_object_arn = local.boto_prefix == null ? "${local.bucket_arn}/*" : "${local.bucket_arn}/${local.boto_prefix}/*"

  csi_prefix     = try(var.csi.prefix, null)
  csi_object_arn = local.csi_prefix == null ? "${local.bucket_arn}/*" : "${local.bucket_arn}/${local.csi_prefix}/*"

  write_object_actions = ["s3:PutObject", "s3:DeleteObject", "s3:AbortMultipartUpload"]
}

# ---- boto: IRSA role for in-cluster SDK access ----
data "aws_iam_policy_document" "boto_assume" {
  count = var.boto == null ? 0 : 1

  dynamic "statement" {
    for_each = var.boto.trusts
    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [statement.value.oidc_provider_arn]
      }

      condition {
        test     = statement.value.match_type
        variable = "${replace(statement.value.oidc_issuer_url, "https://", "")}:sub"
        values   = ["system:serviceaccount:${statement.value.namespace}:${statement.value.service_account}"]
      }
    }
  }
}

resource "aws_iam_role" "boto" {
  count = var.boto == null ? 0 : 1

  name               = var.boto.role_name
  assume_role_policy = data.aws_iam_policy_document.boto_assume[0].json
  tags               = local.tags
}

data "aws_iam_policy_document" "boto" {
  count = var.boto == null ? 0 : 1

  statement {
    sid       = "ListBucket"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [local.bucket_arn]

    dynamic "condition" {
      for_each = local.boto_prefix == null ? [] : [1]
      content {
        test     = "StringLike"
        variable = "s3:prefix"
        values   = ["${local.boto_prefix}/*"]
      }
    }
  }

  # Separate, unconditioned: GetBucketLocation requests carry no s3:prefix key, so it must not
  # sit under the ListBucket prefix condition (it would be denied whenever a prefix is set).
  statement {
    sid       = "GetBucketLocation"
    effect    = "Allow"
    actions   = ["s3:GetBucketLocation"]
    resources = [local.bucket_arn]
  }

  statement {
    sid       = "ReadWriteObjects"
    effect    = "Allow"
    actions   = var.boto.read_write ? concat(["s3:GetObject"], local.write_object_actions) : ["s3:GetObject"]
    resources = [local.boto_object_arn]
  }
}

resource "aws_iam_role_policy" "boto" {
  count = var.boto == null ? 0 : 1

  name   = coalesce(var.boto.policy_name, "${var.boto.role_name}-s3")
  role   = aws_iam_role.boto[0].id
  policy = data.aws_iam_policy_document.boto[0].json
}

# ---- csi: attach an S3 access policy to the shared Mountpoint-S3 driver role(s) ----
data "aws_iam_policy_document" "csi" {
  count = var.csi == null ? 0 : 1

  statement {
    sid       = "ReadBucket"
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:ListBucket", "s3:GetBucketLocation"]
    resources = [local.bucket_arn, local.csi_object_arn]
  }

  dynamic "statement" {
    for_each = var.csi.read_write ? [1] : []
    content {
      sid       = "WriteObjects"
      effect    = "Allow"
      actions   = local.write_object_actions
      resources = [local.csi_object_arn]
    }
  }
}

resource "aws_iam_policy" "csi" {
  count = var.csi == null ? 0 : 1

  name        = coalesce(var.csi.policy_name, "${var.bucket_name}-s3-csi-access-policy")
  description = "Allows the S3 CSI driver to access ${var.bucket_name}"
  policy      = data.aws_iam_policy_document.csi[0].json
  tags        = local.tags
}

resource "aws_iam_role_policy_attachment" "csi" {
  for_each = var.csi == null ? toset([]) : toset(var.csi.role_names)

  role       = each.value
  policy_arn = aws_iam_policy.csi[0].arn
}
