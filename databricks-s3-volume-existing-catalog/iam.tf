## IAM for accessing buckets backing the volumes
## with access role supplied to the databricks_storage_credential
locals {
  aws_principal_account_ids = toset([
    data.aws_caller_identity.current.account_id
  ])
  bucket_access_role = join("/", "role", "databricks", local.dbx_volume_aws_role_name)
  external_ids = [
    "4a2f419c-ae7a-49f1-b774-8f3113d9834d", # CZI Databricks account id
    databricks_storage_credential.volume.storage_credential_id,
  ]
}

#data "aws_iam_policy_document" "volume_dbx_unity_aws_role_assume_role" {
#  statement {
#    principals {
#      type        = "AWS"
#      identifiers = ["arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"]
#    }
#
#    actions = ["sts:AssumeRole"]
#    condition {
#      test     = "StringEquals"
#      variable = "sts:ExternalId"
#      values   = local.external_ids
#    }
#  }
#
#  statement {
#    principals {
#      type = "AWS"
#      identifiers = [
#        for account_id in local.aws_principal_account_ids
#        : "arn:aws:iam::${account_id}:root"
#      ]
#    }
#
#    actions = ["sts:AssumeRole"]
#    condition {
#      test     = "ArnEquals"
#      variable = "aws:PrincipalArn"
#      values = [
#        #"arn:aws:iam::${local.bucket_aws_account_id}:${local.bucket_access_role}"
#        for bucket in var.volume_buckets :
#        "arn:aws:iam::${bucket.bucket_aws_account_id}:${local.bucket_access_role}"
#      ]
#    }
#  }
#}

resource "aws_iam_role" "volume_dbx_unity_aws_role" {
  name               = local.dbx_volume_aws_role_name
  path               = local.path
  #assume_role_policy = data.aws_iam_policy_document.volume_dbx_unity_aws_role_assume_role.json
  assume_role_policy = {
    statement = {
      principals = {
        type        = "AWS"
        identifiers = ["arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"]
      }

      actions = ["sts:AssumeRole"]
      condition = {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = local.external_ids }
    }

    statement = {
      principals = {
        type = "AWS"
        identifiers = [
          for account_id in local.aws_principal_account_ids
          : "arn:aws:iam::${account_id}:root"
        ]
      }

      actions = ["sts:AssumeRole"]
      condition = {
        test     = "ArnEquals"
        variable = "aws:PrincipalArn"
        values = [
          #"arn:aws:iam::${local.bucket_aws_account_id}:${local.bucket_access_role}"
          for bucket in var.volume_buckets :
          "arn:aws:iam::${bucket.bucket_aws_account_id}:${local.bucket_access_role}"
        ]
      }
    }
  }
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
      for bucket in var.volume_buckets : "arn:aws:s3:::${bucket.bucket_name}"
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
      for bucket in var.volume_buckets : "arn:aws:s3:::${bucket.bucket_name}/*"
    ]
  }
  statement {
    sid    = "databricksAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      #"arn:aws:iam::${data.aws_caller_identity.current.account_id}:${local.bucket_access_role}"
      for bucket in var.volume_buckets :
      "arn:aws:iam::${bucket.bucket_aws_account_id}:${local.bucket_access_role}"
    ]
  }
}

resource "aws_iam_policy" "volume_dbx_unity_access_policy" {
  policy = data.aws_iam_policy_document.volume_bucket_dbx_unity_access.json
}

resource "aws_iam_role_policy_attachment" "volume_dbx_unity_aws_access" {
  policy_arn = aws_iam_policy.volume_dbx_unity_access_policy.arn
  role       = local.dbx_volume_aws_role_name
  #role       = aws_iam_role.volume_dbx_unity_aws_role.name
}
