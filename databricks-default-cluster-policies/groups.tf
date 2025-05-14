locals {
  ws_policy_name_prefixes = toset([
    var.policy_name_prefix,
  ])

  policy_group_membership_list = toset([
    for prefix in local.ws_policy_name_prefixes
    : [ for policy_suffix, groups_names in merge(var.policy_map...)
      : [ for group_name in groups_names
        : {"${prefix}${policy_suffix}" = "${group_name}"}
      ]
    ]
  ])
}

# Create Databricks groups for each policy name
resource "databricks_group" "ws_policy_groups" {
  for_each = toset(keys(local.policy_group_membership_list))

  display_name     = each.key
  workspace_access = true
}

# Retrieve the existing Databricks usergroups that need to be assigned
data "databricks_group" "usergroups" {
  for_each = toset(values(local.policy_group_membership_list))

  display_name = each.value
}

# Assign user groups to policy groups per policy-usergroup pair
resource "databricks_group_member" "ws_policy_group_members" {
  for_each = local.policy_group_membership_list

  group_id = data.databricks_group.ws_policy_groups[each.key]
  member_id = data.databricks_group.groups[each.value].id
}
