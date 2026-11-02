resource "databricks_catalog" "catalog" {
  provider                       = databricks.workspace
  for_each                       = { for idx, catalog in var.catalogs : catalog.name => catalog }
  name                           = each.value.name
  storage_root                   = "s3://${module.catalog_bucket.name}/${each.value.catalog_prefix != "" ? each.value.catalog_prefix : each.value.name}"
  comment                        = "this catalog is managed by terraform"
  isolation_mode                 = each.value.isolation_mode
  enable_predictive_optimization = each.value.enable_predictive_optimization
  owner                          = each.value.owner

  depends_on = [databricks_external_location.external_locations]
}

module "tiers" {
  source = "../databricks-uc-privilege-tiers"
}

locals {
  # three representations of the same information for easier access later
  flattened_catalog_groups = flatten([
    for catalog in var.catalogs : concat(
      [
        for code in module.tiers.levels.catalog : {
          catalog       = catalog.name
          key           = code
          builtin       = true
          group_name    = "${catalog.name}_${module.tiers.tiers[code].suffix}"
          group_members = catalog["${code}_members"]
          privileges    = module.tiers.tiers[code].catalog
        }
      ],
      [
        for key, group in catalog.extra_groups : {
          catalog       = catalog.name
          key           = key
          builtin       = false
          group_name    = "${catalog.name}_${key}"
          group_members = group.members
          privileges    = group.privileges
        }
      ],
    )
  ])
  # Grouped so that name collisions reach the preconditions below instead of
  # failing with a generic duplicate-key error.
  catalog_groups = { for group in local.flattened_catalog_groups : group.group_name => group... }
  catalog_group_map = { for catalog in var.catalogs : catalog.name => merge([
    for group in local.flattened_catalog_groups : { (group.key) = group.group_name } if group.catalog == catalog.name
  ]...) }
  flattened_catalog_group_memberships = toset(flatten([
    for group in local.flattened_catalog_groups : [
      for member in group.group_members : {
        group_name = group.group_name
        member     = member
      }
    ]
  ]))

  catalog_grants = { for catalog in var.catalogs : catalog.name => concat(
    [
      for group in local.flattened_catalog_groups : {
        principal  = group.group_name
        privileges = group.privileges
      } if group.catalog == catalog.name
    ],
    catalog.extra_grants,
  ) }
}

resource "databricks_group" "catalog_groups" {
  provider     = databricks.mws
  for_each     = local.catalog_groups
  display_name = each.key

  lifecycle {
    precondition {
      condition     = alltrue([for g in each.value : g.builtin || !contains(module.tiers.reserved_names, g.key)])
      error_message = "extra_groups keys must not be a built-in tier code or suffix (${join(", ", module.tiers.reserved_names)})."
    }
    precondition {
      condition     = length(each.value) == 1
      error_message = "Group name \"${each.key}\" is produced more than once, by catalogs ${join(", ", distinct([for g in each.value : g.catalog]))}; rename the extra_groups key."
    }
  }
}

# NOTE: Authoritative membership management for catalog groups. Permissions set out outside of this will be overwritten.
resource "databricks_grants" "grants" {
  provider = databricks.workspace
  for_each = local.catalog_grants
  catalog  = each.key

  depends_on = [
    databricks_catalog.catalog,
    databricks_group.catalog_groups
  ]

  dynamic "grant" {
    for_each = each.value
    content {
      principal  = grant.value.principal
      privileges = grant.value.privileges
    }
  }

  lifecycle {
    precondition {
      condition     = length(each.value) == length(distinct([for g in each.value : g.principal]))
      error_message = "Catalog \"${each.key}\" has more than one grant for the same principal; merge the privileges into one extra_grants entry."
    }
  }
}

resource "databricks_group_member" "catalog_group_memberships" {
  provider = databricks.mws
  for_each = { for membership in local.flattened_catalog_group_memberships : "${membership.group_name}_${membership.member}" => {
    group_name = membership.group_name
    member     = membership.member
  } }
  group_id  = databricks_group.catalog_groups[each.value.group_name].id
  member_id = each.value.member
}
