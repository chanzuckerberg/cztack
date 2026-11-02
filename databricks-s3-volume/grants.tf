module "tiers" {
  source = "../databricks-uc-privilege-tiers"
}

locals {
  tiers = module.tiers.tiers

  # Only set the members if the catalog and/or schema doesn't already exist
  catalog_mng_members = var.create_catalog ? concat([var.owner_id], var.catalog_mng_members) : []
  catalog_all_members = var.create_catalog ? concat([var.owner_id], var.catalog_all_members) : []
  catalog_r_members   = var.create_catalog ? var.catalog_r_members : []
  catalog_rw_members  = var.create_catalog ? var.catalog_rw_members : []
  catalog_crt_members = var.create_catalog ? var.catalog_crt_members : []
  catalog_usg_members = var.create_catalog ? var.catalog_usg_members : []

  schema_mng_members = var.create_schema ? concat([var.owner_id], var.schema_mng_members) : []
  schema_all_members = var.create_schema ? concat([var.owner_id], var.schema_all_members) : []
  schema_r_members   = var.create_schema ? var.schema_r_members : []
  schema_rw_members  = var.create_schema ? var.schema_rw_members : []
  schema_usg_members = var.create_schema ? var.schema_usg_members : []

  catalog_extra_groups = var.create_catalog ? var.catalog_extra_groups : {}
  schema_extra_groups  = var.create_schema ? var.schema_extra_groups : {}

  catalog_extra_group_members = merge([
    for key, group in local.catalog_extra_groups : { for member in group.members : "${key}/${member}" => { key = key, member = member } }
  ]...)
  schema_extra_group_members = merge([
    for key, group in local.schema_extra_groups : { for member in group.members : "${key}/${member}" => { key = key, member = member } }
  ]...)
  volume_extra_group_members = merge([
    for key, group in var.volume_extra_groups : { for member in group.members : "${key}/${member}" => { key = key, member = member } }
  ]...)

  # Catalog grants are authoritative; one databricks_grants holds them all.
  catalog_grants = concat(
    [for code, group in databricks_group.catalog : { principal = group.display_name, privileges = local.tiers[code].catalog }],
    [for key, group in databricks_group.catalog_extra : { principal = group.display_name, privileges = var.catalog_extra_groups[key].privileges }],
    var.create_catalog ? var.catalog_extra_grants : [],
  )

  # Schema and Volume grants are additive, keyed by principal. Repeated
  # principals are merged.
  schema_extra_grants = {
    for principal, privileges in merge(
      { for key, group in databricks_group.schema_extra : group.display_name => [var.schema_extra_groups[key].privileges] },
      { for g in(var.create_schema ? var.schema_extra_grants : []) : g.principal => g.privileges... },
    ) : principal => distinct(flatten(privileges))
  }
  volume_extra_grants = {
    for principal, privileges in merge(
      { for key, group in databricks_group.volume_extra : group.display_name => [var.volume_extra_groups[key].privileges] },
      { for g in var.volume_extra_grants : g.principal => g.privileges... },
    ) : principal => distinct(flatten(privileges))
  }
}

# groups
resource "databricks_group" "catalog" {
  depends_on = [databricks_catalog.volume[0]]
  for_each   = toset(var.create_catalog ? module.tiers.levels.catalog : [])
  provider   = databricks.mws

  display_name = "${local.catalog_name}_${local.tiers[each.value].suffix}"
}

resource "databricks_group" "schema" {
  depends_on = [databricks_schema.volume[0]]
  for_each   = toset(var.create_schema ? module.tiers.levels.schema : [])
  provider   = databricks.mws

  display_name = "${local.catalog_name}_${local.schema_name}_${local.tiers[each.value].suffix}"
}

resource "databricks_group" "volume" {
  for_each = toset(module.tiers.levels.volume)
  provider = databricks.mws

  display_name = "${local.catalog_name}_${local.schema_name}_${databricks_volume.volume.name}_${local.tiers[each.value].suffix}"
}

resource "databricks_group" "catalog_extra" {
  depends_on = [databricks_catalog.volume]
  for_each   = local.catalog_extra_groups
  provider   = databricks.mws

  display_name = "${local.catalog_name}_${each.key}"

  lifecycle {
    precondition {
      condition     = !contains(module.tiers.reserved_names, each.key)
      error_message = "catalog_extra_groups key \"${each.key}\" is a built-in tier code or suffix (${join(", ", module.tiers.reserved_names)})."
    }
  }
}

resource "databricks_group" "schema_extra" {
  depends_on = [databricks_schema.volume]
  for_each   = local.schema_extra_groups
  provider   = databricks.mws

  display_name = "${local.catalog_name}_${local.schema_name}_${each.key}"

  lifecycle {
    precondition {
      condition     = !contains(module.tiers.reserved_names, each.key)
      error_message = "schema_extra_groups key \"${each.key}\" is a built-in tier code or suffix (${join(", ", module.tiers.reserved_names)})."
    }
  }
}

resource "databricks_group" "volume_extra" {
  for_each = var.volume_extra_groups
  provider = databricks.mws

  display_name = "${local.catalog_name}_${local.schema_name}_${databricks_volume.volume.name}_${each.key}"

  lifecycle {
    precondition {
      condition     = !contains(module.tiers.reserved_names, each.key)
      error_message = "volume_extra_groups key \"${each.key}\" is a built-in tier code or suffix (${join(", ", module.tiers.reserved_names)})."
    }
  }
}

moved {
  from = databricks_group.catalog["manage"]
  to   = databricks_group.catalog["mng"]
}

moved {
  from = databricks_group.catalog["read"]
  to   = databricks_group.catalog["r"]
}

moved {
  from = databricks_group.catalog["write"]
  to   = databricks_group.catalog["rw"]
}

moved {
  from = databricks_group.catalog["use"]
  to   = databricks_group.catalog["usg"]
}

moved {
  from = databricks_group.schema["manage"]
  to   = databricks_group.schema["mng"]
}

moved {
  from = databricks_group.schema["read"]
  to   = databricks_group.schema["r"]
}

moved {
  from = databricks_group.schema["write"]
  to   = databricks_group.schema["rw"]
}

moved {
  from = databricks_group.schema["use"]
  to   = databricks_group.schema["usg"]
}

moved {
  from = databricks_group.volume["manage"]
  to   = databricks_group.volume["mng"]
}

moved {
  from = databricks_group.volume["read"]
  to   = databricks_group.volume["r"]
}

moved {
  from = databricks_group.volume["write"]
  to   = databricks_group.volume["rw"]
}

# group memberships
# Kept as one resource per tier: they're keyed by member ID, so merging them
# would need a moved block per member to avoid removing and re-adding members.
resource "databricks_group_member" "catalog_manage" {
  provider = databricks.mws
  for_each = toset(local.catalog_mng_members)

  group_id  = databricks_group.catalog["mng"].id
  member_id = each.value
}

resource "databricks_group_member" "catalog_all" {
  provider = databricks.mws
  for_each = toset(local.catalog_all_members)

  group_id  = databricks_group.catalog["all"].id
  member_id = each.value
}

resource "databricks_group_member" "catalog_r" {
  provider = databricks.mws
  for_each = toset(local.catalog_r_members)

  group_id  = databricks_group.catalog["r"].id
  member_id = each.value
}

resource "databricks_group_member" "catalog_rw" {
  provider = databricks.mws
  for_each = toset(local.catalog_rw_members)

  group_id  = databricks_group.catalog["rw"].id
  member_id = each.value
}

resource "databricks_group_member" "catalog_crt" {
  provider = databricks.mws
  for_each = toset(local.catalog_crt_members)

  group_id  = databricks_group.catalog["crt"].id
  member_id = each.value
}

resource "databricks_group_member" "catalog_use" {
  provider = databricks.mws
  for_each = toset(local.catalog_usg_members)

  group_id  = databricks_group.catalog["usg"].id
  member_id = each.value
}

resource "databricks_group_member" "schema_manage" {
  provider = databricks.mws
  for_each = toset(local.schema_mng_members)

  group_id  = databricks_group.schema["mng"].id
  member_id = each.value
}

resource "databricks_group_member" "schema_all" {
  provider = databricks.mws
  for_each = toset(local.schema_all_members)

  group_id  = databricks_group.schema["all"].id
  member_id = each.value
}

resource "databricks_group_member" "schema_r" {
  provider = databricks.mws
  for_each = toset(local.schema_r_members)

  group_id  = databricks_group.schema["r"].id
  member_id = each.value
}

resource "databricks_group_member" "schema_rw" {
  provider = databricks.mws
  for_each = toset(local.schema_rw_members)

  group_id  = databricks_group.schema["rw"].id
  member_id = each.value
}

resource "databricks_group_member" "schema_use" {
  provider = databricks.mws
  for_each = toset(local.schema_usg_members)

  group_id  = databricks_group.schema["usg"].id
  member_id = each.value
}

resource "databricks_group_member" "volume_manage" {
  provider = databricks.mws
  for_each = toset(var.volume_mng_members)

  group_id  = databricks_group.volume["mng"].id
  member_id = each.value
}

resource "databricks_group_member" "volume_all" {
  provider = databricks.mws
  for_each = toset(var.volume_all_members)

  group_id  = databricks_group.volume["all"].id
  member_id = each.value
}

resource "databricks_group_member" "volume_r" {
  provider = databricks.mws
  for_each = toset(var.volume_r_members)

  group_id  = databricks_group.volume["r"].id
  member_id = each.value
}

resource "databricks_group_member" "volume_rw" {
  provider = databricks.mws
  for_each = toset(var.volume_rw_members)

  group_id  = databricks_group.volume["rw"].id
  member_id = each.value
}

resource "databricks_group_member" "catalog_extra" {
  provider = databricks.mws
  for_each = local.catalog_extra_group_members

  group_id  = databricks_group.catalog_extra[each.value.key].id
  member_id = each.value.member
}

resource "databricks_group_member" "schema_extra" {
  provider = databricks.mws
  for_each = local.schema_extra_group_members

  group_id  = databricks_group.schema_extra[each.value.key].id
  member_id = each.value.member
}

resource "databricks_group_member" "volume_extra" {
  provider = databricks.mws
  for_each = local.volume_extra_group_members

  group_id  = databricks_group.volume_extra[each.value.key].id
  member_id = each.value.member
}

# catalog grants #############################
# NOTE: Authoritative. Catalog grants set outside of this module will be revoked.
resource "databricks_grants" "catalog" {
  count      = var.create_catalog ? 1 : 0
  provider   = databricks.workspace
  depends_on = [databricks_catalog.volume]

  catalog = local.catalog_name

  dynamic "grant" {
    for_each = local.catalog_grants
    content {
      principal  = grant.value.principal
      privileges = grant.value.privileges
    }
  }

  lifecycle {
    precondition {
      condition     = length(local.catalog_grants) == length(distinct([for g in local.catalog_grants : g.principal]))
      error_message = "The catalog has more than one grant for the same principal; merge the privileges into one catalog_extra_grants entry."
    }
  }
}

# The per-tier catalog grants are replaced by databricks_grants.catalog. Forget
# them instead of destroying them, so no privilege is revoked during the switch.
removed {
  from = databricks_grant.catalog_all
  lifecycle {
    destroy = false
  }
}

removed {
  from = databricks_grant.catalog_manage
  lifecycle {
    destroy = false
  }
}

removed {
  from = databricks_grant.catalog_read
  lifecycle {
    destroy = false
  }
}

removed {
  from = databricks_grant.catalog_write
  lifecycle {
    destroy = false
  }
}

removed {
  from = databricks_grant.catalog_use
  lifecycle {
    destroy = false
  }
}

# schema grants
resource "databricks_grant" "schema" {
  for_each   = databricks_group.schema
  provider   = databricks.workspace
  depends_on = [databricks_schema.volume[0]]

  schema     = "${local.catalog_name}.${local.schema_name}"
  principal  = each.value.display_name
  privileges = local.tiers[each.key].schema
}

resource "databricks_grant" "schema_extra" {
  for_each   = local.schema_extra_grants
  provider   = databricks.workspace
  depends_on = [databricks_schema.volume[0]]

  schema     = "${local.catalog_name}.${local.schema_name}"
  principal  = each.key
  privileges = each.value

  lifecycle {
    precondition {
      condition     = !contains([for group in databricks_group.schema : group.display_name], each.key)
      error_message = "schema_extra_grants principal \"${each.key}\" is one of this module's schema groups; use schema_<code>_members instead."
    }
  }
}

moved {
  from = databricks_grant.schema_all[0]
  to   = databricks_grant.schema["all"]
}

moved {
  from = databricks_grant.schema_manage[0]
  to   = databricks_grant.schema["mng"]
}

moved {
  from = databricks_grant.schema_r[0]
  to   = databricks_grant.schema["r"]
}

moved {
  from = databricks_grant.schema_rw[0]
  to   = databricks_grant.schema["rw"]
}

moved {
  from = databricks_grant.schema_use[0]
  to   = databricks_grant.schema["usg"]
}

# volume grants
resource "databricks_grant" "volume" {
  for_each = databricks_group.volume
  provider = databricks.workspace

  volume     = databricks_volume.volume.id
  principal  = each.value.display_name
  privileges = local.tiers[each.key].volume
}

resource "databricks_grant" "volume_extra" {
  for_each = local.volume_extra_grants
  provider = databricks.workspace

  volume     = databricks_volume.volume.id
  principal  = each.key
  privileges = each.value

  lifecycle {
    precondition {
      condition     = !contains([for group in databricks_group.volume : group.display_name], each.key)
      error_message = "volume_extra_grants principal \"${each.key}\" is one of this module's volume groups; use volume_<code>_members instead."
    }
  }
}

moved {
  from = databricks_grant.volume_all
  to   = databricks_grant.volume["all"]
}

moved {
  from = databricks_grant.volume_manage
  to   = databricks_grant.volume["mng"]
}

moved {
  from = databricks_grant.volume_r
  to   = databricks_grant.volume["r"]
}

moved {
  from = databricks_grant.volume_rw
  to   = databricks_grant.volume["rw"]
}
