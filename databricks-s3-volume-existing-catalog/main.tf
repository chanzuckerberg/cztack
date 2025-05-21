# Volume bucket (UC supported)

// https://docs.databricks.com/administration-guide/multiworkspace/iam-role.html#language-Your%C2%A0VPC,%C2%A0custom

data "aws_caller_identity" "current" {
  provider = aws
}

locals {
  databricks_aws_account = "414351767826" # Databricks' own AWS account, not CZI's. See https://docs.databricks.com/en/administration-guide/account-settings-e2/credentials.html#step-1-create-a-cross-account-iam-role

  # ensure bucket_aws_account_id is set
  volume_buckets = {
    for bucket in var.volume_buckets :
    bucket.volume_name => merge(
      bucket,
      {
        bucket_aws_account_id = coalesce(
          bucket.bucket_aws_account_id,
          data.aws_caller_identity.current.account_id,
        ),
        bucket_access_role_name = replace("${var.catalog_name}-${bucket.volume_name}-vol-ax-role", "-", "_"),
        bucket_access_role_arn = join(
          ":", [
            "arn",
            "aws",
            "iam",
            "",
            bucket.bucket_aws_account_id,
            join("/", ["role", "databricks", bucket.bucket_access_role_name])
          ]
        ),
        bucket_arn = join(
          ":", [
            "arn",
            "aws",
            "s3",
            "",
            "",
            bucket.bucket_name
          ]
        )
      },
    )
  }
}

### Databricks storage credential - allows workspace to access an external location.
### NOTE: names need to be unique across an account, not just a workspace

resource "databricks_storage_credential" "volume" {
  for_each = local.volume_buckets

  name = replace("${var.catalog_name}-${each.key}-volume-storage-credential", "_", "-")
  aws_iam_role {
    role_arn = each.value.bucket_access_role_arn
    # is really
    #role_arn = aws_iam_role.volume_dbx_unity_aws_role.arn
    # but using string to avoid circular dependency
    #role_arn = "arn:aws:iam::445567094889:role/databricks/databricks_sci_data_logs_buckets_reader"
  }
  force_update = true
  comment      = "Managed by Terraform - access for the volumes in ${var.catalog_name}"
}

# upstream external location sometimes takes a moment to register
resource "time_sleep" "wait_30_seconds" {
  depends_on = [databricks_storage_credential.volume]

  create_duration = "30s"
}

resource "databricks_external_location" "volume" {
  for_each   = { for bucket in local.volume_buckets : bucket.volume_name => bucket }
  depends_on = [time_sleep.wait_30_seconds]

  name            = replace("${each.value.volume_name}-external-location", "_", "-")
  url             = "s3://${each.value.bucket_name}"
  credential_name = databricks_storage_credential.volume[each.key]
  comment         = "Managed by Terraform - access for the volume named ${each.value.bucket_name} in ${var.catalog_name}"
}

# New volume
resource "databricks_volume" "volume" {
  for_each         = { for bucket in local.volume_buckets : bucket.volume_name => bucket }
  depends_on       = [databricks_external_location.volume]
  name             = each.value.volume_name
  catalog_name     = var.catalog_name
  schema_name      = var.schema_name
  volume_type      = "EXTERNAL"
  storage_location = "s3://${each.value.bucket_name}${each.value.bucket_prefix != "" ? "/${each.value.bucket_prefix}" : ""}"
  owner            = var.catalog_owner
  comment          = "Managed by Terraform - access for the volume named ${each.value.bucket_name} in ${var.catalog_name}"
}
