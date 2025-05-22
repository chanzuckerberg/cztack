## IAM for accessing buckets backing the volumes
## with access role supplied to the databricks_storage_credential
locals {
  aws_principal_account_ids = toset(compact(
    concat(
      [data.aws_caller_identity.current.account_id],
      [for bucket in local.volume_buckets : bucket.bucket_aws_account_id]
    )
  ))
}

data "aws_iam_policy_document" "volume_dbx_unity_aws_role_assume_role" {
  for_each = local.volume_buckets

  statement {
    principals {
      type = "AWS"
      identifiers = toset(concat([
        "arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"
        ],
        [
          for account_id in [
            data.aws_caller_identity.current.account_id,
            each.value.bucket_aws_account_id,
          ]
          : "arn:aws:iam::${account_id}:root"
        ],
      ))
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values = [
        "4a2f419c-ae7a-49f1-b774-8f3113d9834d", # CZI Databricks account id
        databricks_storage_credential.volume[each.key].storage_credential_id,
      ]

    }
  }

  statement {
    principals {
      type = "AWS"
      identifiers = concat(
        # account roots
        [
          for account_id in toset([
            data.aws_caller_identity.current.account_id,
            each.value.bucket_aws_account_id,
          ])
          : "arn:aws:iam::${account_id}:root"
        ]
        ## role self-assumption
        #[
        #  each.value.bucket_access_role_arn
        #  # should match result of aws_iam_role.volume_dbx_unity_aws_role.arn
        #]
      )
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "ArnEquals"
      variable = "aws:PrincipalArn"
      values = toset([
        for bucket in local.volume_buckets :
        bucket.bucket_access_role_arn
      ])
    }
  }
}

resource "aws_iam_role" "volume_dbx_unity_aws_role" {
  for_each = local.volume_buckets

  name = each.value.bucket_access_role_name
  path = "/databricks/"

  assume_role_policy = data.aws_iam_policy_document.volume_dbx_unity_aws_role_assume_role[each.key].json
}


### Policy document to access default volume bucket and assume role
data "aws_iam_policy_document" "volume_bucket_dbx_unity_access" {
  depends_on = [aws_iam_role.volume_dbx_unity_aws_role]

  for_each = local.volume_buckets

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
      each.value.bucket_arn
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
      "${each.value.bucket_arn}/*"
    ]
  }
  statement {
    sid    = "databricksAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      #"arn:aws:iam::${data.aws_caller_identity.current.account_id}:${local.bucket_access_role_name}"
      each.value.bucket_access_role_arn,
    ]
  }
}

resource "aws_iam_policy" "volume_dbx_unity_access_policy" {
  for_each = local.volume_buckets

  policy = data.aws_iam_policy_document.volume_bucket_dbx_unity_access[each.key].json
}

resource "aws_iam_role_policy_attachment" "volume_dbx_unity_aws_access" {
  for_each = local.volume_buckets

  policy_arn = aws_iam_policy.volume_dbx_unity_access_policy[each.key].arn
  role       = each.value.bucket_access_role_name
}
