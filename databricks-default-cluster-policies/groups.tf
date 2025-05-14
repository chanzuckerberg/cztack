locals {
  ws_policy_name_prefixes = toset([
    var.policy_name_prefix,
  ])

  policy_group_membership_list = toset(flatten([
    for prefix in local.ws_policy_name_prefixes
    : [ for policy_suffix, groups_names in merge(var.policy_map...)
      : [ for group_name in groups_names
        : {"${prefix}${policy_suffix}" = "${group_name}"}
      ]
    ]
  ]))

  ws_cluster_policy_names = toset(flatten([for pair in local.policy_group_membership_list : keys(pair)]))
  usergroups_names = toset(flatten([for pair in local.policy_group_membership_list : flatten(values(pair))]))
}

# Create Databricks groups for each policy name
resource "databricks_group" "ws_cluster_policy_groups" {
  for_each = local.ws_cluster_policy_names

  display_name     = each.key
  workspace_access = true
}

# Retrieve the existing Databricks usergroups that need to be assigned
data "databricks_group" "usergroups" {
  for_each = local.usergroups_names

  display_name = each.value
}

# Assign user groups to policy groups per policy-usergroup pair
resource "databricks_group_member" "ws_policy_group_members" {
  for_each = {
    for i, e in local.policy_group_membership_list
    : i => e
  }

  group_id = databricks_group.ws_cluster_policy_groups[each.value.key]
  member_id = data.databricks_group.usergroups[each.value.value].id
}
