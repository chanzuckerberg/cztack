locals {
  # Only set the grant principals if the catalog and/or schema doesn't already exist
  catalog_r_grant_principals = var.create_catalog ? var.catalog_r_grant_principals : []
  catalog_rw_grant_principals = var.create_catalog ? var.catalog_rw_grant_principals : []
  schema_r_grant_principals = var.create_schema ? var.schema_r_grant_principals : []
  schema_rw_grant_principals = var.create_schema ? var.schema_rw_grant_principals : []
}

# catalog
resource "databricks_grant" "catalog_r" {
  depends_on = [databricks_catalog.volume[0]]
  for_each   = toset(local.catalog_r_grant_principals)

  catalog    = local.catalog_name
  principal  = each.value
  privileges = ["USE_CATALOG", "BROWSE"]
}

resource "databricks_grant" "catalog_rw" {
  depends_on = [databricks_catalog.volume[0]]
  for_each  = toset(local.catalog_rw_grant_principals)

  catalog   = local.catalog_name
  principal = each.value
  privileges = [
    "USE_CATALOG",
    "BROWSE",
    "APPLY_TAG",
    "CREATE_SCHEMA",
  ]
}

# schema
resource "databricks_grant" "schema_r" {
  depends_on = [databricks_schema.volume[0]]
  for_each   = toset(local.schema_r_grant_principals)

  schema     = "${local.catalog_name}.${local.schema_name}"
  principal  = each.value
  privileges = ["USE_SCHEMA", "SELECT", "EXECUTE"]
}

resource "databricks_grant" "schema_rw" {
  depends_on = [databricks_schema.volume[0]]
  for_each  = toset(local.schema_rw_grant_principals)

  schema    = "${local.catalog_name}.${local.schema_name}"
  principal = each.value
  privileges = [
    "USE_SCHEMA",
    "SELECT",
    "EXECUTE",
    "REFRESH",
    "APPLY_TAG",
    "CREATE_FUNCTION",
    "CREATE_TABLE",
    "CREATE_VOLUME",
    "CREATE_MATERIALIZED_VIEW",
  ]
}

# volume
resource "databricks_grant" "volume_r" {
  for_each   = toset(var.volume_r_grant_principals)
  volume     = databricks_volume.volume.id
  principal  = each.value
  privileges = ["READ_VOLUME"]
}

resource "databricks_grant" "volume_rw" {
  for_each   = toset(var.volume_rw_grant_principals)
  volume     = databricks_volume.volume.id
  principal  = each.value
  privileges = [
    "READ_VOLUME",
    "WRITE_VOLUME",
  ]
}