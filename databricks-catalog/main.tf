resource "databricks_catalog" "catalog" {
  name           = var.catalog_name
  storage_root   = "s3://${var.bucket_name}"
  comment        = "this catalog is managed by terraform"
  isolation_mode = var.isolation_mode
  owner          = var.catalog_owner
}

resource "databricks_grants" "grants" {
  catalog = databricks_catalog.catalog.name

  depends_on = [
    databricks_catalog.catalog
  ]

  dynamic "grant" {
    for_each = toset(var.all_privileges_groups)
    content {
      principal = grant.value
      privileges = [
        "ALL_PRIVILEGES",
      ]
    }
  }

  dynamic "grant" {
    for_each = toset(var.read_privileges_groups)
    content {
      principal = grant.value
      privileges = [
        "USE_CATALOG",
        "USE_SCHEMA",
        "SELECT",
      ]
    }
  }

  dynamic "grant" {
    for_each = toset(var.write_privileges_groups)
    content {
      principal = grant.value
      privileges = [
        "USE_CATALOG",
        "USE_SCHEMA",
        "SELECT",
        "CREATE_TABLE",
        "CREATE_SCHEMA",
        "MODIFY",
      ]
    }
  }
}