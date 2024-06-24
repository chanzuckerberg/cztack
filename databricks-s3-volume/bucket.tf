locals {
  standard_grant_principals = concat(["arn:aws:iam::${local.databricks_aws_account}:root"], var.additional_rw_bucket_grant_arns)
}

data "aws_iam_policy_document" "databricks-s3" {
  count = var.volume_bucket != null ? 0 : 1

  # standard UC access
  statement {
    sid    = "dbxBucketAccess"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = local.standard_grant_principals
    }
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration",
    ]
    resources = [
      "arn:aws:s3:::${local.bucket_name}",
    ]
  }
  statement {
    sid    = "dbxObjAccess"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = local.standard_grant_principals
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      "arn:aws:s3:::${local.bucket_name}/*" # root access
    ]
  }
  # storage credential access - uses string to avoid race condition of role v. bucket creation
  statement {
    sid    = "dbxSCBucketAccess"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }
    condition {
      test     = "ArnEquals"
      variable = "aws:PrincipalArn"
      values = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.path}${local.unity_aws_role_name}",
      ]
    }
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration",
    ]
    resources = [
      "arn:aws:s3:::${local.bucket_name}",
    ]
  }
  statement {
    sid    = "dbxSCObjAccess"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }
    condition {
      test     = "ArnEquals"
      variable = "aws:PrincipalArn"
      values = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.path}${local.unity_aws_role_name}",
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      "arn:aws:s3:::${local.bucket_name}/*"
    ]
  }

}

module "databricks_bucket" {
  count = var.volume_bucket != null ? 0 : 1
  depends_on = [
    aws_iam_role.dbx_unity_aws_role
  ]

  source           = "github.com/chanzuckerberg/cztack//aws-s3-private-bucket?ref=v0.71.0"
  bucket_name      = local.bucket_name
  bucket_policy    = data.aws_iam_policy_document.databricks-s3[0].json
  project          = var.tags["project"]
  env              = var.tags["env"]
  service          = var.tags["service"]
  owner            = var.tags["owner"]
  object_ownership = var.bucket_object_ownership
}