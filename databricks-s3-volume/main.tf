# Volume bucket (UC supported)

// https://docs.databricks.com/administration-guide/multiworkspace/iam-role.html#language-Your%C2%A0VPC,%C2%A0custom
locals {
  unity_aws_role_name      = "${var.catalog_name}-${var.volume_name}-unity"
  catalog_name             = replace(var.catalog_name, "-", "_") # SQL don't work with hyphens
  schema_name              = replace(var.volume_name, "-", "_")  # SQL don't work with hyphens

  path                   = "/databricks/"
  databricks_aws_account = "414351767826"                                                                      # Databricks' own AWS account, not CZI's. See https://docs.databricks.com/en/administration-guide/account-settings-e2/credentials.html#step-1-create-a-cross-account-iam-role
  bucket_name            = var.volume_bucket != null ? var.volume_bucket : replace(var.catalog_name, "_", "-") # buckets don't work with underscores
}

### Databricks storage credential - allows workspace to access an external location.
### NOTE: names need to be unique across an account, not just a workspace
### NOTE: 

resource "databricks_storage_credential" "volume" {
  depends_on = [
    resource.aws_iam_role.dbx_unity_aws_role,
    resource.aws_iam_role_policy_attachment.dbx_unity_aws_access,
    module.databricks_bucket
  ]

  name = "${local.catalog_name}"
  aws_iam_role {
    role_arn = aws_iam_role.dbx_unity_aws_role.arn
  }
  comment = "Managed by Terraform - access for ${var.volume_name}"
}

resource "databricks_external_location" "volume" {
  name            = "${local.catalog_name}"
  url             = "s3://${local.bucket_name}"
  credential_name = databricks_storage_credential.volume.name
  comment         = "Managed by Terraform - access for ${var.volume_name}"
}

# New catalog, schema, and volume

resource "databricks_catalog" "volume" {
  depends_on   = [databricks_external_location.volume]
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
  catalog_name = databricks_catalog.volume.name
  name         = local.schema_name
  comment      = "This schema is managed by Terraform - ${var.volume_comment}"
  owner        = var.catalog_owner
  properties   = var.volume_schema_properties
}

resource "databricks_volume" "volume" {
  depends_on       = [databricks_external_location.volume]
  name             = "${local.catalog_name}_${local.schema_name}"
  catalog_name     = local.catalog_name
  schema_name      = databricks_schema.volume.name
  volume_type      = "EXTERNAL"
  storage_location = "s3://${local.bucket_name}/${local.schema_name}"
  owner            = var.catalog_owner
  comment          = "This volume is managed by Terraform - ${var.volume_comment}"
}