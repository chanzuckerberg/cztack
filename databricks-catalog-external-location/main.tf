data "aws_caller_identity" "current" {
  provider = aws
}

locals {
  iam_role_namespace = "databricks"
  iam_role_path      = "/${local.iam_role_namespace}/"

  bucket_name_prefix = coalesce(
    var.override_bucket_name_prefix,
    "${var.tags.project}-${var.tags.env}"
  )
  bucket_name_suffix = "-dbx-catalog-bucket"
  bucket_name        = "${local.bucket_name_prefix}${local.bucket_name_suffix}"

  iam_role_name_infix = coalesce(var.override_role_name_infix, var.tags.env)
  iam_role_name       = format("external_location_dbx_%s_aws_role", local.iam_role_name_infix)
  iam_role_arn        = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.iam_role_path}${local.iam_role_name}"
}

## Bucket and policy
data "aws_iam_policy_document" "catalog_bucket_access" {
  statement {
    sid    = "bucketObjAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.databricks_external_location_iam_role.arn]
    }
    resources = [
      "${module.catalog_bucket.arn}/*",
    ]
  }
  statement {
    sid    = "bucketAccess"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.databricks_external_location_iam_role.arn]
    }
    resources = [
      module.catalog_bucket.arn,
    ]
  }
}

module "catalog_bucket" {
  source        = "github.com/chanzuckerberg/cztack//aws-s3-private-bucket?ref=v0.60.1"
  bucket_name   = local.bucket_name
  bucket_policy = data.aws_iam_policy_document.catalog_bucket_access.json
  project       = var.tags.project
  env           = var.tags.env
  service       = var.tags.service
  owner         = var.tags.owner
}

## Databricks external location and IAM
data "aws_iam_policy_document" "databricks_external_location_assume_role" {
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"
      ]
    }

    actions = ["sts:AssumeRole"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [var.databricks_external_id]
    }
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = ["sts:AssumeRole"]
    condition {
      test     = "ArnEquals"
      variable = "aws:PrincipalArn"

      values = [local.iam_role_arn]
    }
  }
}

resource "aws_iam_role" "databricks_external_location_iam_role" {
  name               = local.iam_role_name
  path               = local.iam_role_path
  assume_role_policy = data.aws_iam_policy_document.databricks_external_location_assume_role.json
}

### Policy documents to access bucket and assume role
data "aws_iam_policy_document" "databricks_external_location_bucket_access" {
  statement {
    sid    = "databricksObjAccess"
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
      "${module.catalog_bucket.arn}/*",
      module.catalog_bucket.arn,
    ]
  }

  statement {
    sid       = "databricksAssumeRole"
    actions   = ["sts:AssumeRole"]
    resources = [local.iam_role_arn]
  }
}

### Policies to access bucket
resource "aws_iam_policy" "databricks_external_location_bucket_access" {
  policy = data.aws_iam_policy_document.databricks_external_location_bucket_access.json
}

### Attachments for policies to access bucket, to the role that Databricks can assume
resource "aws_iam_role_policy_attachment" "databricks_external_location_bucket_access" {
  policy_arn = aws_iam_policy.databricks_external_location_bucket_access.arn
  role       = aws_iam_role.databricks_external_location_iam_role.name
}

resource "aws_iam_role_policy" "databricks_external_location_access_role_policy" {
  name_prefix = local.iam_role_namespace
  role        = aws_iam_role.databricks_external_location_iam_role.id
  policy      = data.aws_iam_policy_document.databricks_external_location_bucket_access.json
}

### Databricks storage credential - allows workspace to access an external location.
### NOTE: names need to be unique across an account, not just a workspace
resource "databricks_storage_credential" "external" {
  depends_on = [
    resource.aws_iam_role.databricks_external_location_iam_role,
    module.catalog_bucket
  ]
  name = aws_iam_role.databricks_external_location_iam_role.name
  aws_iam_role {
    role_arn = aws_iam_role.databricks_external_location_iam_role.arn
  }
  isolation_mode = "ISOLATION_MODE_ISOLATED"
  comment        = "Managed by Terraform"
}

## user/group Grants to an external storage
resource "databricks_grants" "databricks_credential_grants" {
  depends_on = [
    resource.databricks_storage_credential.external
  ]
  storage_credential = databricks_storage_credential.external.id
  dynamic "grant" {
    for_each = toset(var.all_privileges_groups)
    content {
      principal = grant.value
      privileges = [
        "ALL_PRIVILEGES",
      ]
    }
  }
}

resource "databricks_external_location" "external_locations" {
  depends_on = [
    resource.databricks_storage_credential.external
  ]
  name            = var.external_location_name
  url             = "s3://${local.bucket_name}"
  credential_name = databricks_storage_credential.external.id
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  comment         = "Managed by Terraform"
}

resource "databricks_grants" "databricks_external_location_grants" {
  external_location = databricks_external_location.external_locations.id
  dynamic "grant" {
    for_each = toset(var.all_privileges_groups)
    content {
      principal = grant.value
      privileges = [
        "ALL_PRIVILEGES",
      ]
    }
  }
}
