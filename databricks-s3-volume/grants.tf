# catalog
resource "databricks_grant" "catalog_r" {
  for_each = toset(var.catalog_r_grant_principals)
  catalog = databricks_catalog.volume.name
  grant {
    principal  = "Data Scientists"
    privileges = ["USE_CATALOG", "USE_SCHEMA", "SELECT"]
  }
}

resource "databricks_grant" "catalog_rw" {
  for_each = toset(var.catalog_rw_grant_principals)
  catalog = databricks_catalog.volume.name
  grant {
    principal  = "Data Scientists"
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
}

# schema
resource "databricks_grant" "schema_r" {
  for_each = toset(var.schema_r_grant_principals)
  schema = databricks_schema.volume.id
  grant {
    principal  = "Data Engineers"
    privileges = ["USE_SCHEMA", "SELECT", "READ_VOLUME"]
  }
}

resource "databricks_grant" "schema_rw" {
  for_each = toset(var.schema_rw_grant_principals)
  schema = databricks_schema.volume.id
  grant {
    principal  = "Data Engineers"
    privileges = [
        "APPLY_TAG",
        "CREATE_FUNCTION",
        "CREATE_TABLE",
        "CREATE_VOLUME",
        "USE_SCHEMA" "EXECUTE",
        "MODIFY",
        "REFRESH",
        "SELECT",
        "READ_VOLUME",
        "WRITE_VOLUME"
    ]
  }
}

# volume
resource "databricks_grant" "volume_r" {
  for_each = toset(var.volume_r_grant_principals)
  volume = databricks_volume.volume.id
  grant {
    principal  = "Data Engineers"
    privileges = ["READ_VOLUME"]
  }
}

resource "databricks_grant" "volume_rw" {
  for_each = toset(var.volume_rw_grant_principals)
  volume = databricks_volume.volume.id
  grant {
    principal  = "Data Engineers"
    privileges = ["READ_VOLUME", "WRITE_VOLUME"]
  }
}