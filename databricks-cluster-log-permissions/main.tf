# - Creates a standard instance policy to allow clusters to write cluster logs to a destination S3 bucket
# - For a given list of instance profiles, also appends a policy attachment to allow them to write cluster logs, too

###
locals {
  default_role_name    = "cluster_log_cluster_role" # standard role for clusters - allows both writing and reading cluster logs for only the same workspace
  read_write_role_name = "cluster_log_rw_role"      # special role - allows both writing and reading cluster logs for all workspaces
  path                 = "/databricks/"

  # hacky way to validate if this workspace/cluster should have read permissions
  # tflint-ignore: terraform_unused_declarations
  validate_add_reader = (var.add_reader == true && var.env != var.global_reader_env) ? tobool("add_reader is not supported for this environment") : true

  databricks_bucket_cluster_log_prefix = "cluster-logs"

  # kms grants - all roles can read and write
  read_write_operations = ["Encrypt", "GenerateDataKey", "Decrypt"]
}

data "aws_iam_policy_document" "assume_role_for_cluster_log_cluster" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}
resource "aws_iam_role" "cluster_log_cluster_role" {
  name               = local.default_role_name
  path               = local.path
  description        = "Role for cluster to write to cluster log bucket"
  assume_role_policy = data.aws_iam_policy_document.assume_role_for_cluster_log_cluster.json
}

resource "aws_iam_role" "cluster_log_rw_role" {
  count = var.add_reader == true ? 1 : 0

  name               = local.read_write_role_name
  path               = local.path
  description        = "Role for cluster to read from and write to cluster log bucket"
  assume_role_policy = data.aws_iam_policy_document.assume_role_for_cluster_log_cluster.json
}

###
## write and limited read access
data "aws_iam_policy_document" "cluster_log_bucket_write_access" {
  statement {
    sid = "ReadWriteClusterLogs"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      "arn:aws:s3:::${var.databricks_logs_bucket_name}/${local.databricks_bucket_cluster_log_prefix}/*",
      "arn:aws:s3:::${var.databricks_logs_bucket_name}"
    ]
  }
  statement {
    sid = "ReadWriteEncryptedClusterLogs"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey",
    ]

    resources = [
      var.bucket_kms_encryption_key_arn
    ]
  }
}

resource "aws_iam_policy" "cluster_log_bucket_write_access" {
  name   = "cluster_log_bucket_write_access_policy"
  path   = local.path
  policy = data.aws_iam_policy_document.cluster_log_bucket_write_access.json
}

resource "aws_iam_role_policy_attachment" "write_access_attachment_default_role" {
  policy_arn = aws_iam_policy.cluster_log_bucket_write_access.arn
  role       = local.default_role_name
}

resource "aws_iam_role_policy_attachment" "write_access_attachment_rw_role" {
  count = var.add_reader == true ? 1 : 0

  policy_arn = aws_iam_policy.cluster_log_bucket_write_access.arn
  role       = local.read_write_role_name
}

## non-standard global-read access

data "aws_iam_policy_document" "cluster_log_bucket_read_access" {
  count = var.add_reader == true ? 1 : 0

  statement {
    sid = "ReadAllClusterLogs"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]

    resources = [
      "arn:aws:s3:::${var.databricks_logs_bucket_name}/*",
      "arn:aws:s3:::${var.databricks_logs_bucket_name}"
    ]
  }
}

resource "aws_iam_policy" "cluster_log_bucket_read_access" {
  count = var.add_reader == true ? 1 : 0

  name   = "cluster_log_bucket_read_access_policy"
  path   = local.path
  policy = data.aws_iam_policy_document.cluster_log_bucket_read_access[0].json
}

resource "aws_iam_role_policy_attachment" "read_access_attachment" {
  count = var.add_reader == true ? 1 : 0

  policy_arn = aws_iam_policy.cluster_log_bucket_read_access[0].arn
  role       = local.read_write_role_name
}

## kms access

data "aws_caller_identity" "current" {
  provider = aws
}

resource "aws_kms_grant" "bucket_kms_encryption_key_grant_default" {
  provider = aws.logs_destination

  name              = "cluster-log-kms-grant-${data.aws_caller_identity.current.account_id}-write"
  key_id            = var.bucket_kms_encryption_key_arn
  grantee_principal = aws_iam_role.cluster_log_cluster_role.arn
  operations        = local.read_write_operations
}

resource "aws_kms_grant" "bucket_kms_encryption_key_grant_rw" {
  count    = var.add_reader == true ? 1 : 0
  provider = aws.logs_destination

  name              = "cluster-log-kms-grant-${data.aws_caller_identity.current.account_id}-read-write"
  key_id            = var.bucket_kms_encryption_key_arn
  grantee_principal = aws_iam_role.cluster_log_rw_role[0].arn
  operations        = local.read_write_operations
}

## standard instance profile(s)

resource "aws_iam_instance_profile" "cluster_log_cluster" {
  name = "cluster-log-cluster-instance-profile"
  path = local.path
  role = aws_iam_role.cluster_log_cluster_role.name
}

resource "databricks_instance_profile" "cluster_log_cluster" {
  depends_on           = [aws_iam_instance_profile.cluster_log_cluster]
  instance_profile_arn = aws_iam_instance_profile.cluster_log_cluster.arn
}

resource "aws_iam_instance_profile" "cluster_log_cluster_rw" {
  count = var.add_reader == true ? 1 : 0

  name = "cluster-log-rw-instance-profile"
  path = local.path
  role = aws_iam_role.cluster_log_rw_role[0].name
}

resource "databricks_instance_profile" "cluster_log_cluster_rw" {
  count = var.add_reader == true ? 1 : 0

  depends_on           = [aws_iam_instance_profile.cluster_log_cluster_rw]
  instance_profile_arn = aws_iam_instance_profile.cluster_log_cluster_rw[0].arn
}

## attach policies to given list of existing instance profiles

resource "aws_iam_role_policy_attachment" "additional_write_access_attachment" {
  for_each = toset(var.existing_role_names)

  policy_arn = aws_iam_policy.cluster_log_bucket_write_access.arn
  role       = each.value
}

resource "aws_kms_grant" "additional_bucket_kms_encryption_key_grant" {
  for_each = toset(var.existing_role_names)
  provider = aws.logs_destination

  name              = "cluster-log-kms-grant-${data.aws_caller_identity.current.account_id}"
  key_id            = var.bucket_kms_encryption_key_arn
  grantee_principal = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/databricks/${each.value}"
  operations        = local.read_write_operations
}