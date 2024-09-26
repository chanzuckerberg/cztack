# Volume bucket (UC supported)

// https://docs.databricks.com/administration-guide/multiworkspace/iam-role.html#language-Your%C2%A0VPC,%C2%A0custom
locals {
  unity_aws_role_name = "${var.catalog_name}-unity"

  # Create non-hyphenated versions of the catalog and schema names if catalog and/or schema doesnt exist. Else, use the provided names
  catalog_name        = var.create_catalog ? replace(var.catalog_name, "-", "_") : var.catalog_name
  schema_name         = var.create_schema ? replace(var.schema_name, "-", "_") : var.schema_name
  volume_name         = replace(var.volume_name, "-", "_")

  path                   = "/databricks/"
  databricks_aws_account = "414351767826"                                                                      # Databricks' own AWS account, not CZI's. See https://docs.databricks.com/en/administration-guide/account-settings-e2/credentials.html#step-1-create-a-cross-account-iam-role
  bucket_name            = var.volume_bucket != null ? var.volume_bucket : replace(var.catalog_name, "_", "-") # buckets don't work with underscores
}

### Databricks storage credential - allows workspace to access an external location.
### NOTE: names need to be unique across an account, not just a workspace
### NOTE: 

resource "databricks_storage_credential" "volume" {
  count = var.create_catalog ? 1 : 0

  depends_on = [
    resource.aws_iam_role.dbx_unity_aws_role,
    resource.aws_iam_role_policy_attachment.dbx_unity_aws_access,
    module.databricks_bucket
  ]

  name = local.catalog_name
  aws_iam_role {
    role_arn = aws_iam_role.dbx_unity_aws_role[0].arn
  }
  comment = "Managed by Terraform - access for ${var.catalog_name}"
}

# upstream external location sometimes takes a moment to register
resource "time_sleep" "wait_30_seconds" {
  depends_on = [databricks_storage_credential.volume[0]]

  create_duration = "30s"
}

resource "databricks_external_location" "volume" {
  count = (var.create_catalog || var.volume_bucket) ? 1 : 0
  depends_on      = [time_sleep.wait_30_seconds]

  name            = local.catalog_name
  url             = "s3://${local.bucket_name}"
  credential_name = databricks_storage_credential.volume[0].name
  comment         = "Managed by Terraform - access for ${var.catalog_name}"
}

# New catalog, schema, and volume

resource "databricks_catalog" "volume" {
  count = var.create_catalog ? 1 : 0

  depends_on   = [databricks_external_location.volume[0]]
  name         = local.catalog_name
  metastore_id = var.metastore_id
  owner        = var.catalog_owner
  storage_root = "s3://${local.bucket_name}"
  comment      = "this catalog is managed by terraform - default volume catalog for Databricks workspace ${var.workspace_name}"
  properties = {
    purpose = "this catalog is managed by terraform - default volume catalog for Databricks workspace ${var.workspace_name}"
  }
  isolation_mode = "ISOLATED"
}

resource "databricks_schema" "volume" {
  count = var.create_schema ? 1 : 0

  depends_on   = [databricks_catalog.volume]
  catalog_name = local.catalog_name
  name         = local.schema_name
  comment      = "This schema is managed by Terraform - ${var.volume_comment}"
  owner        = var.catalog_owner
  properties   = var.volume_schema_properties
}

resource "databricks_volume" "volume" {
  depends_on       = [databricks_external_location.volume, databricks_schema.volume]
  name             = "${local.volume_name}"
  catalog_name     = local.catalog_name
  schema_name      = local.schema_name
  volume_type      = "EXTERNAL"
  storage_location = "s3://${local.bucket_name}/${local.schema_name}"
  owner            = var.catalog_owner
  comment          = "This volume is managed by Terraform - ${var.volume_comment}"
}