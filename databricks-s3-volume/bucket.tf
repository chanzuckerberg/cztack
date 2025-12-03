locals {
  standard_grant_principals = concat(
    ["arn:aws:iam::${local.databricks_aws_account}:root"],
    var.additional_rw_bucket_grant_arns
  )
}

data "aws_iam_policy_document" "databricks-s3" {
  for_each                  = local.creating_s3_buckets
  override_policy_documents = lookup(var.override_policy_documents, each.key, [])

  # standard UC access
  statement {
    sid    = "dbxBucketAccess"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.standard_grant_principals
    }
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration",
    ]
    resources = distinct([
      "arn:aws:s3:::${each.key}",
    ])
  }
  statement {
    sid    = "dbxObjAccess"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.standard_grant_principals
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = distinct([
      "arn:aws:s3:::${each.key}/*" # root access
    ])
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
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.iam_role_path}${local.unity_aws_role_name}",
      ]
    }
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration",
    ]
    resources = distinct([
      "arn:aws:s3:::${each.key}",
    ])
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
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.iam_role_path}${local.unity_aws_role_name}",
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = distinct([
      "arn:aws:s3:::${each.key}/*"
    ])
  }

}

module "databricks_bucket" {
  for_each = local.creating_s3_buckets
  depends_on = [
    aws_iam_role.dbx_unity_aws_role
  ]

  source           = "github.com/chanzuckerberg/cztack//aws-s3-private-bucket?ref=v0.71.0"
  bucket_name      = each.key
  bucket_policy    = data.aws_iam_policy_document.databricks-s3[each.key].json
  project          = var.tags["project"]
  env              = var.tags["env"]
  service          = var.tags["service"]
  owner            = var.tags["owner"]
  object_ownership = var.bucket_object_ownership
}