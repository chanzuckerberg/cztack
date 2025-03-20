## Databricks external location and IAM

data "aws_caller_identity" "current" {
  provider = aws
}

data "aws_iam_policy_document" "dbx_unity_aws_role_assume_role" {
  count = local.create_storage_credentials ? 1 : 0

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
      values   = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.iam_role_path}${local.unity_aws_role_name}"]
    }
  }
}

resource "aws_iam_role" "dbx_unity_aws_role" {
  count = local.create_storage_credentials ? 1 : 0

  name               = local.unity_aws_role_name
  path               = local.iam_role_path
  assume_role_policy = data.aws_iam_policy_document.dbx_unity_aws_role_assume_role[0].json
}

### Policy document to access default volume bucket and assume role
data "aws_iam_policy_document" "volume_bucket_dbx_unity_access" {
  for_each = (
    local.create_storage_credentials ?
    toset([for resource in local.dbx_resource_storage_config : resource["bucket_name"]]) :
    toset([])
  )

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
      "arn:aws:s3:::${each.key}",
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
      "arn:aws:s3:::${each.key}/*",
    ]
  }
  statement {
    sid    = "databricksAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.iam_role_path}${local.unity_aws_role_name}"
    ]
  }
}

resource "aws_iam_policy" "dbx_unity_access_policy" {
  for_each = (
    local.create_storage_credentials ?
    toset([for resource in local.dbx_resource_storage_config : resource["bucket_name"]]) :
    toset([])
  )

  policy = data.aws_iam_policy_document.volume_bucket_dbx_unity_access[each.key].json
}

resource "aws_iam_role_policy_attachment" "dbx_unity_aws_access" {
  count = local.create_storage_credentials ? 1 : 0

  policy_arn = aws_iam_policy.dbx_unity_access_policy[0].arn
  role       = aws_iam_role.dbx_unity_aws_role[0].name
}