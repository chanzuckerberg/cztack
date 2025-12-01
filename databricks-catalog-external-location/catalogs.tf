resource "databricks_catalog" "catalog" {
  provider = databricks.workspace
  for_each                       = { for idx, catalog in var.catalogs : catalog.name => catalog }
  name                           = each.value.name
  storage_root                   = "s3://${module.catalog_bucket.name}/${each.value.catalog_prefix != "" ? each.value.catalog_prefix : each.value.name}"
  comment                        = "this catalog is managed by terraform"
  isolation_mode                 = each.value.isolation_mode
  enable_predictive_optimization = each.value.enable_predictive_optimization
  owner                          = each.value.owner

  depends_on = [databricks_external_location.external_locations]
}

locals {
  group_types = ["all", "manage", "read", "write", "use"]
  # three representations of the same information for easier access later
  flattened_catalog_groups = toset(flatten([
    for idx, catalog in var.catalogs : [
        for group_type in local.group_types : {
          catalog = catalog.name
          group_type   = group_type
          group_name = "${catalog.name}_${group_type}"
          group_members = lookup(catalog, "${group_type}_privileges_members", [])
        }
    ]
  ]))
  catalog_group_map = {for idx, catalog in var.catalogs : catalog.name => {
    for group_type in local.group_types : group_type => "${catalog.name}_${group_type}"
  }}
  flattened_catalog_group_memberships = toset(flatten([
    for group in local.flattened_catalog_groups : [
      for member in group.group_members : {
        catalog     = group.catalog
        group_type  = group.group_type
        group_name  = group.group_name
        member = member
      }
    ]
  ]))
}

resource "databricks_group" "catalog_groups" {
  provider = databricks.mws
  for_each                       = toset([for group in local.flattened_catalog_groups : group.group_name])
  display_name                   = each.value
}

# NOTE: Authoritative membership management for catalog groups. Permissions set out outside of this will be overwritten.
resource "databricks_grants" "grants" { 
  provider = databricks.workspace
  for_each = local.catalog_group_map
  catalog  = each.value.name

  depends_on = [
    databricks_catalog.catalog,
    databricks_group.catalog_groups
  ]

  grant {
    principal = each.value["manage"]
    privileges = [
      "ALL_PRIVILEGES",
      "MANAGE",
    ]
  }

  grant {
    principal = each.value["all"]
    privileges = [
      "ALL_PRIVILEGES",
    ]
  }

  grant {
    principal = each.value["write"]
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

  grant {
    principal = each.value["read"]
    privileges = [
      "USE_CATALOG",
      "USE_SCHEMA",
      "SELECT",
      "BROWSE",
    ]
  }

  grant {
    principal = each.value["use"]
    privileges = [
      "USE_CATALOG",
    ]
  }

}

resource "databricks_group_member" "catalog_group_memberships" {
  provider = databricks.mws
  for_each = local.flattened_catalog_group_memberships
  group_id  = databricks_group.catalog_groups[each.key].id
  member_id = each.value.member
}