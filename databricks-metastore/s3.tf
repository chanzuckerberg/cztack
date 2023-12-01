## Sets up a metastore for use with Databricks Unity Catalog
## https://docs.databricks.com/data-governance/unity-catalog/get-started.html

locals {
  metastore_access_role_name = "${local.name}-access"
}

## Bucket which will be used for the metastore, with KMS for encryption

resource "aws_s3_bucket" "metastore" {
  bucket = local.name
  tags   = var.tags
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.metastore_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_kms_key" "metastore_key" {
  description             = "KMS key for ${local.name}"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  tags                    = var.tags
}

resource "aws_kms_alias" "metastore_key_alias" {
  name          = "alias/${local.name}-key"
  target_key_id = aws_kms_key.metastore_key.id
}

## Allow Databricks role to assume our role

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "metastore_assumerole_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = [
        # Default role for all databricks accounts https://docs.databricks.com/data-governance/unity-catalog/automate.html#configure-storage-for-a-metastore
        "arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values = [
        # This is our non-education account number
        var.databricks_external_id
      ]
    }
  }
  # AWS introduced a new change 6/30/23 that requires IAM policies to self-reference and allow the role to 
  # assume itself. We can't just use the arn as-is since the role might not exist yet
  # https://docs.databricks.com/data-governance/unity-catalog/get-started.html#configure-a-storage-bucket-and-iam-role-in-aws
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
    condition {
      test     = "ArnEquals"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.metastore_access_role_name}"]
    }
  }
}


## Create role which will be assumed by Databricks Unity Catalog

resource "aws_iam_role" "metastore_access" {
  name               = local.metastore_access_role_name
  assume_role_policy = data.aws_iam_policy_document.metastore_assumerole_policy.json
  tags               = var.tags
}


## Allow our role access S3 and KMS

resource "aws_iam_policy_attachment" "metastore_access" {
  name       = "${local.name}-policy"
  roles      = [aws_iam_role.metastore_access.name]
  policy_arn = aws_iam_policy.metastore_access.arn
}

resource "aws_iam_policy" "metastore_access" {
  name        = "${local.name}-s3-kms-access"
  description = "Allow access to the ${local.name} bucket"
  policy      = data.aws_iam_policy_document.metastore_role_access_policy.json
}

data "aws_iam_policy_document" "metastore_role_access_policy" {
  statement {
    sid    = "S3RWBucketAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.metastore.id}",
      "arn:aws:s3:::${aws_s3_bucket.metastore.id}/*"
    ]
  }
  statement {
    sid    = "KMSAccess"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*"
    ]
    resources = [
      aws_kms_key.metastore_key.arn
    ]
  }
  statement {
    sid    = "STSAssumeRoleAccess"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      aws_iam_role.metastore_access.arn
    ]
  }
}