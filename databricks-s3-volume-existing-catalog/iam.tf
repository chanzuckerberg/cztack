## Databricks external location and IAM

data "aws_caller_identity" "current" {
  provider = aws
}

data "aws_iam_policy_document" "volume_dbx_unity_aws_role_assume_role" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"]
    }

    actions = ["sts:AssumeRole"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = ["4a2f419c-ae7a-49f1-b774-8f3113d9834d"]
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
      values   = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.path}${local.dbx_volume_aws_role_name}"]
    }
  }
}

resource "aws_iam_role" "volume_dbx_unity_aws_role" {
  name               = local.dbx_volume_aws_role_name
  path               = local.path
  assume_role_policy = data.aws_iam_policy_document.volume_dbx_unity_aws_role_assume_role.json
}


### Policy document to access default volume bucket and assume role
data "aws_iam_policy_document" "volume_bucket_dbx_unity_access" {
  statement {
    sid    = "dbxSCBucketAccess"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration"
    ]
    resources = [
      "arn:aws:s3:::${var.volume_bucket}"
    ]
  }
  statement {
    sid    = "dbxSCObjAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      "arn:aws:s3:::${var.volume_bucket}/*"
    ]
  }
  statement {
    sid    = "databricksAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.path}${local.dbx_volume_aws_role_name}"
    ]
  }
}

resource "aws_iam_policy" "volume_dbx_unity_access_policy" {
  policy = data.aws_iam_policy_document.volume_bucket_dbx_unity_access.json
}

resource "aws_iam_role_policy_attachment" "volume_dbx_unity_aws_access" {
  policy_arn = aws_iam_policy.volume_dbx_unity_access_policy.arn
  role       = aws_iam_role.volume_dbx_unity_aws_role.name
}
