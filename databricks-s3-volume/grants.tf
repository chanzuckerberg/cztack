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
  privileges = ["USE_CATALOG", "USE_SCHEMA", "SELECT"]
}

resource "databricks_grant" "catalog_rw" {
  depends_on = [databricks_catalog.volume[0]]
  for_each  = toset(local.catalog_rw_grant_principals)

  catalog   = local.catalog_name
  principal = "Data Scientists"
  privileges = [
    "APPLY_TAG",
    "CREATE_CONNECTION",
    "CREATE_SCHEMA",
    "USE_CATALOG",
    "CREATE_FUNCTION",
    "CREATE_TABLE",
    "EXECUTE",
    "MODIFY",
    "REFRESH",
    "SELECT",
    "READ_VOLUME",
    "WRITE_VOLUME",
    "USE_SCHEMA",
  ]
}

# schema
resource "databricks_grant" "schema_r" {
  depends_on = [databricks_schema.volume[0]]
  for_each   = toset(local.schema_r_grant_principals)

  schema     = "${local.catalog_name}.${local.schema_name}"
  principal  = each.value
  privileges = ["USE_SCHEMA", "SELECT", "READ_VOLUME"]
}

resource "databricks_grant" "schema_rw" {
  depends_on = [databricks_schema.volume[0]]
  for_each  = toset(local.schema_rw_grant_principals)

  schema    = "${local.catalog_name}.${local.schema_name}"
  principal = each.value
  privileges = [
    "APPLY_TAG",
    "CREATE_FUNCTION",
    "CREATE_TABLE",
    "CREATE_VOLUME",
    "USE_SCHEMA",
    "EXECUTE",
    "MODIFY",
    "REFRESH",
    "SELECT",
    "READ_VOLUME",
    "WRITE_VOLUME"
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
  privileges = ["READ_VOLUME", "WRITE_VOLUME"]
}