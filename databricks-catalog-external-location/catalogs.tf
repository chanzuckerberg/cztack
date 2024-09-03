resource "databricks_catalog" "catalog" {
  for_each       = { for idx, catalog in var.catalogs : catalog.name => catalog }
  name           = each.value.name
  storage_root   = "s3://${module.catalog_bucket.name}/${each.value.catalog_prefix != "" ? each.value.catalog_prefix : each.value.name}"
  comment        = "this catalog is managed by terraform"
  isolation_mode = each.value.isolation_mode
  owner          = each.value.owner
}

resource "databricks_grants" "grants" {
  for_each = { for idx, catalog in var.catalogs : catalog.name => catalog }
  catalog  = each.value.name

  depends_on = [
    databricks_catalog.catalog
  ]

  dynamic "grant" {
    for_each = toset(each.value.all_privileges_groups)
    content {
      principal = grant.value
      privileges = [
        "ALL_PRIVILEGES",
      ]
    }
  }

  dynamic "grant" {
    for_each = toset(each.value.read_privileges_groups)
    content {
      principal = grant.value
      privileges = [
        "USE_CATALOG",
        "USE_SCHEMA",
        "SELECT",
        "BROWSE",
      ]
    }
  }

  dynamic "grant" {
    for_each = toset(each.value.write_privileges_groups)
    content {
      principal = grant.value
      privileges = [
        "USE_CATALOG",
        "USE_SCHEMA",
        "SELECT",
        "CREATE_TABLE",
        "CREATE_SCHEMA",
        "MODIFY",
        "BROWSE",
      ]
    }
  }
}