# Volume bucket (UC supported)

// https://docs.databricks.com/administration-guide/multiworkspace/iam-role.html#language-Your%C2%A0VPC,%C2%A0custom
locals {
  name = "${var.tags.project}-${var.tags.env}-${var.tags.service}"
  dbx_volume_aws_role_name = "${local.name}-${var.volume_name}-role"
  dbx_volume_storage_credential_name = "${local.name}-${var.volume_name}-storage-credential"

  path                   = "/databricks/"
  databricks_aws_account = "414351767826" # Databricks' own AWS account, not CZI's. See https://docs.databricks.com/en/administration-guide/account-settings-e2/credentials.html#step-1-create-a-cross-account-iam-role
}

### Databricks storage credential - allows workspace to access an external location.
### NOTE: names need to be unique across an account, not just a workspace

resource "databricks_storage_credential" "volume" {
  depends_on = [
    resource.aws_iam_role.volume_dbx_unity_aws_role,
    resource.aws_iam_role_policy_attachment.volume_bucket_dbx_unity_access
  ]

  name = local.dbx_volume_storage_credential_name
  aws_iam_role {
    role_arn = aws_iam_role.volume_dbx_unity_aws_role.arn
  }
  comment = "Managed by Terraform - access for the volume named ${var.volume_name} in ${var.catalog_name}"
}

# upstream external location sometimes takes a moment to register
resource "time_sleep" "wait_30_seconds" {
  depends_on = [databricks_storage_credential.volume]

  create_duration = "30s"
}

resource "databricks_external_location" "volume" {
  depends_on      = [time_sleep.wait_30_seconds]

  name            = var.volume_name
  url             = "s3://${var.volume_bucket}"
  credential_name = databricks_storage_credential.volume.name
  comment         = "Managed by Terraform - access for the volume named ${var.volume_name} in ${var.catalog_name}"
}

# New volume

resource "databricks_volume" "volume" {
  depends_on       = [databricks_external_location.volume]
  name             = "${var.volume_name}"
  catalog_name     = var.catalog_name
  schema_name      = var.schema_name
  volume_type      = "EXTERNAL"
  storage_location = "s3://${var.volume_bucket}/${var.schema_name}"
  owner            = var.catalog_owner
  comment         = "Managed by Terraform - access for the volume named ${var.volume_name} in ${var.catalog_name}"
}
