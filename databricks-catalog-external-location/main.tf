data "aws_caller_identity" "current" {
  provider = aws
}

locals {
  path                   = "/databricks/"
  name                   = "${var.tags.project}-${var.tags.env}"
  external_location_name = "external-${local.name}"
  bucket_name            = "${local.name}-dbx-catalog-bucket"
  iam_role_name          = "external_location_dbx_${var.tags.env}_aws_role"
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
      type        = "AWS"
      identifiers = ["arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"]
    }

    actions = ["sts:AssumeRole"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [var.databricks_external_id]
    }
  }
}

resource "aws_iam_role" "databricks_external_location_iam_role" {
  name               = local.iam_role_name
  path               = local.path
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
  name            = local.external_location_name
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
