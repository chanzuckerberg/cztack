# Volume bucket (UC supported)

// https://docs.databricks.com/administration-guide/multiworkspace/iam-role.html#language-Your%C2%A0VPC,%C2%A0custom
locals {
  dbx_volume_aws_role_name = "${var.catalog_name}-volumes-role"
  path                     = "/databricks/"
  databricks_aws_account   = "414351767826" # Databricks' own AWS account, not CZI's. See https://docs.databricks.com/en/administration-guide/account-settings-e2/credentials.html#step-1-create-a-cross-account-iam-role
}

### Databricks storage credential - allows workspace to access an external location.
### NOTE: names need to be unique across an account, not just a workspace

resource "databricks_storage_credential" "volume" {
  depends_on = [
    resource.aws_iam_role.volume_dbx_unity_aws_role,
    resource.aws_iam_role_policy_attachment.volume_dbx_unity_aws_access
  ]

  name = "${var.catalog_name}-volumes-storage-credential"
  aws_iam_role {
    #role_arn = aws_iam_role.volume_dbx_unity_aws_role.arn
    role_arn = "arn:aws:iam::445567094889:role/databricks/databricks_sci_data_logs_buckets_reader"
  }
  comment = "Managed by Terraform - access for the volumes in ${var.catalog_name}"
}

# upstream external location sometimes takes a moment to register
resource "time_sleep" "wait_30_seconds" {
  depends_on = [databricks_storage_credential.volume]

  create_duration = "30s"
}

resource "databricks_external_location" "volume" {
  for_each   = { for bucket in var.volume_buckets : bucket.volume_name => bucket }
  depends_on = [time_sleep.wait_30_seconds]

  name            = "${each.value.volume_name}-external-location"
  url             = "s3://${each.value.bucket_name}"
  credential_name = databricks_storage_credential.volume.name
  comment         = "Managed by Terraform - access for the volume named ${each.value.bucket_name} in ${var.catalog_name}"
}

# New volume
resource "databricks_volume" "volume" {
  for_each         = { for bucket in var.volume_buckets : bucket.volume_name => bucket }
  depends_on       = [databricks_external_location.volume]
  name             = each.value.volume_name
  catalog_name     = var.catalog_name
  schema_name      = var.schema_name
  volume_type      = "EXTERNAL"
  storage_location = "s3://${each.value.bucket_name}${each.value.bucket_prefix != "" ? "/${each.value.bucket_prefix}" : ""}"
  owner            = var.catalog_owner
  comment          = "Managed by Terraform - access for the volume named ${each.value.bucket_name} in ${var.catalog_name}"
}
