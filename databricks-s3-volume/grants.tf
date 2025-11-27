locals {
  # Only set the grant principals if the catalog and/or schema doesn't already exist
  catalog_manage_grant_principals = concat(
    [var.owner],
    var.create_catalog ? var.catalog_manage_grant_principals : []
  )
  catalog_all_priv_grant_principals = concat(
    [var.owner],
    var.create_catalog ? var.catalog_all_priv_grant_principals : []
  )
  catalog_r_grant_principals         = var.create_catalog ? var.catalog_r_grant_principals : []
  catalog_rw_grant_principals        = var.create_catalog ? var.catalog_rw_grant_principals : []
  catalog_usage_grant_principals        = var.create_catalog ? var.catalog_usage_grant_principals : []

  schema_manage_grant_principals = concat(
    [var.owner],
    var.create_schema ? var.schema_manage_grant_principals : []
  )
  schema_all_priv_grant_principals = concat(
    [var.owner],
    var.create_schema ? var.schema_all_priv_grant_principals : []
  )
  schema_r_grant_principals          = var.create_schema ? var.schema_r_grant_principals : []
  schema_rw_grant_principals         = var.create_schema ? var.schema_rw_grant_principals : []
  schema_usage_grant_principals        = var.create_schema ? var.schema_usage_grant_principals : []

  group_types = ["all", "manage", "read", "write", "use"]
}

# groups
resource "databricks_group" "catalog" {
  depends_on = [databricks_catalog.volume[0]]
  for_each   = toset(local.group_types)
  provider = databricks.mws

  display_name = "${local.catalog_name}_${each.value}"
}

resource "databricks_group" "schema" {
  depends_on = [databricks_schema.volume[0]]
  for_each   = toset(local.group_types)
  provider = databricks.mws

  display_name = "${local.schema_name}_${each.value}"
}

resource "databricks_group" "volume" {
  for_each   = toset(local.group_types)
  provider = databricks.mws

  display_name = "${databricks_volume.volume.name}_${each.value}"
}

# group memberships
resource "databricks_group_member" "catalog_manage" {
  for_each = locals.catalog_manage_grant_principals
  provider = databricks.mws

  group_id  = databricks_group.catalog["manage"].id
  member_id = each.value
}

resource "databricks_group_member" "catalog_all" {
  for_each = locals.catalog_all_priv_grant_principals
  provider = databricks.mws

  group_id  = databricks_group.catalog["all"].id
  member_id = each.value
}

resource "databricks_group_member" "catalog_r" {
  provider = databricks.mws
  for_each = locals.catalog_r_grant_principals

  group_id  = databricks_group.catalog["read"].id
  member_id = each.value
}

resource "databricks_group_member" "catalog_rw" {
  provider = databricks.mws
  for_each = locals.catalog_rw_grant_principals

  group_id  = databricks_group.catalog["write"].id
  member_id = each.value
}

resource "databricks_group_member" "schema_manage" {
  provider = databricks.mws
  for_each = locals.schema_manage_grant_principals

  group_id  = databricks_group.schema["manage"].id
  member_id = each.value
}

resource "databricks_group_member" "schema_all" {
  provider = databricks.mws
  for_each = locals.schema_all_priv_grant_principals

  group_id  = databricks_group.schema["all"].id
  member_id = each.value
}

resource "databricks_group_member" "schema_r" {
  provider = databricks.mws
  for_each = locals.schema_r_grant_principals

  group_id  = databricks_group.schema["read"].id
  member_id = each.value
}

resource "databricks_group_member" "schema_rw" {
  provider = databricks.mws
  for_each = locals.schema_rw_grant_principals

  group_id  = databricks_group.schema["write"].id
  member_id = each.value
}

resource "databricks_group_member" "volume_manage" {
  provider = databricks.mws
  for_each = var.volume_manage_grant_principals

  group_id  = databricks_group.volume["manage"].id
  member_id = each.value
}

resource "databricks_group_member" "volume_all" {
  provider = databricks.mws
  for_each = var.volume_all_grant_principals

  group_id  = databricks_group.volume["all"].id
  member_id = each.value
}

resource "databricks_group_member" "volume_r" {
  provider = databricks.mws
  for_each = var.volume_r_grant_principals

  group_id  = databricks_group.volume["read"].id
  member_id = each.value
}

resource "databricks_group_member" "volume_rw" {
  provider = databricks.mws
  for_each = var.volume_rw_grant_principals

  group_id  = databricks_group.volume["write"].id
  member_id = each.value
}

# catalog grants #############################
resource "databricks_grant" "catalog_all" {
  provider = databricks.workspace
  depends_on = [databricks_catalog.volume[0]]

  catalog    = local.catalog_name
  principal  = databricks_group.catalog["all"].id
  privileges = ["ALL_PRIVILEGES"]
}

resource "databricks_grant" "catalog_manage" {
  provider = databricks.workspace
  depends_on = [databricks_catalog.volume[0]]

  catalog    = local.catalog_name
  principal  = databricks_group.catalog["manage"].id
  privileges = ["ALL_PRIVILEGES", "MANAGE"]
}

resource "databricks_grant" "catalog_read" {
  provider = databricks.workspace
  depends_on = [databricks_catalog.volume[0]]

  catalog    = local.catalog_name
  principal  = databricks_group.catalog["read"].id
  privileges = [
    "USE_CATALOG",
    "USE_SCHEMA",
    "SELECT",
    "BROWSE",
  ]
}

resource "databricks_grant" "catalog_write" {
  provider = databricks.workspace
  depends_on = [databricks_catalog.volume[0]]

  catalog    = local.catalog_name
  principal  = databricks_group.catalog["write"].id
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

resource "databricks_grant" "catalog_use" {
  provider = databricks.workspace
  depends_on = [databricks_catalog.volume[0]]

  catalog    = local.catalog_name
  principal  = databricks_group.catalog["use"].id
  privileges = ["USE_CATALOG"]
}

# schema grants
resource "databricks_grant" "schema_all" {
  provider = databricks.workspace
  depends_on = [databricks_schema.volume[0]]

  schema     = "${local.catalog_name}.${local.schema_name}"
  principal  = databricks_group.schema["all"].id
  privileges = ["ALL_PRIVILEGES"]
}

resource "databricks_grant" "schema_manage" {
  provider = databricks.workspace
  depends_on = [databricks_schema.volume[0]]

  schema     = "${local.catalog_name}.${local.schema_name}"
  principal  = databricks_group.schema["manage"].id
  privileges = ["ALL_PRIVILEGES", "MANAGE"]
}

resource "databricks_grant" "schema_r" {
  provider = databricks.workspace
  depends_on = [databricks_schema.volume[0]]

  schema     = "${local.catalog_name}.${local.schema_name}"
  principal  = databricks_group.schema["read"].id
  privileges = ["USE_SCHEMA", "SELECT", "EXECUTE"]
}

resource "databricks_grant" "schema_rw" {
  provider = databricks.workspace
  depends_on = [databricks_schema.volume[0]]

  schema    = "${local.catalog_name}.${local.schema_name}"
  principal  = databricks_group.schema["write"].id
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

resource "databricks_grant" "schema_use" {
  provider = databricks.workspace
  depends_on = [databricks_schema.volume[0]]
  
  schema    = "${local.catalog_name}.${local.schema_name}"
  principal  = databricks_group.schema["use"].id
  privileges = ["USE_SCHEMA"]
}

# volume grants
resource "databricks_grant" "volume_all" {
  provider = databricks.workspace

  volume     = databricks_volume.volume.id
  principal  = databricks_group.volume["all"].id
  privileges = ["ALL_PRIVILEGES"]
}

resource "databricks_grant" "volume_manage" {
  provider = databricks.workspace

  volume     = databricks_volume.volume.id
  principal  = databricks_group.volume["manage"].id
  privileges = ["ALL_PRIVILEGES", "MANAGE"]
}

resource "databricks_grant" "volume_r" {
  provider = databricks.workspace

  volume     = databricks_volume.volume.id
  principal  = databricks_group.volume["read"].id
  privileges = ["READ_VOLUME"]
}

resource "databricks_grant" "volume_rw" {
  provider = databricks.workspace
  
  volume    = databricks_volume.volume.id
  principal = databricks_group.volume["write"].id
  privileges = [
    "READ_VOLUME",
    "WRITE_VOLUME",
  ]
}
