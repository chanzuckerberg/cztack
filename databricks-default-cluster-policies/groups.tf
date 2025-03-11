locals {
  ws_policy_name_prefixes = toset([
    var.policy_name_prefix,
  ])

  # Define the policies with existing groups mapped to each policy
  policies = var.policy_map

  # Generate full workspace policy names by prefixing policy names
  all_ws_policy_names = flatten([
    for prefix in local.ws_policy_name_prefixes : [
      for policy_map in local.policies :
      "${prefix}${keys(policy_map)[0]}"
    ]
  ])

  # Create a flat map of policy names to associated groups
  policy_group_map = merge([for policy_map in local.policies : policy_map]...)
}

# Create Databricks groups for each policy name
resource "databricks_group" "ws_policy_groups" {
  for_each = toset(local.all_ws_policy_names)

  display_name     = each.key
  workspace_access = true
}

# Retrieve the existing Databricks groups that need to be assigned
data "databricks_group" "groups" {
  for_each = toset(flatten([
    for group in local.policy_group_map : group
  ]))

  display_name = each.value
}

# Assign the existing groups to the newly created policy groups
resource "databricks_group_member" "ws_policy_group_members" {
  for_each = databricks_group.ws_policy_groups

  group_id = each.value.id

  # Assign all existing groups that correspond to this policy group
  member_id = data.databricks_group.groups[local.policy_group_map[replace(each.key, var.policy_name_prefix, "")][0]].id
}
