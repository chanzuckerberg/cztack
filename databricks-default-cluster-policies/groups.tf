locals {
  ws_policy_name_prefixes = toset([
    var.policy_name_prefix,
  ])
  # Aligned with each policy module in main.tf
  policies = toset([
    "Legacy Shared Compute",
    "Personal Compute",
    "Large Personal Compute",
    "Power User Compute",
    "Job Compute",
    "Small Job Compute",
    "Large GPU Large Clusters",
    "Large GPU Personal",
    "Large GPU Small Clusters",
    "Small Clusters",
    "Superset Compute",
    "Single Node Job Compute",
  ])
  all_ws_policy_names = flatten([
    for prefix in local.ws_policy_name_prefixes : [
      for policy in local.policies : "${prefix}${policy}"
    ]
  ])
}

resource "databricks_group" "ws_policy_groups" {
  for_each = toset(local.all_ws_policy_names)

  display_name     = each.key
  workspace_access = true
}
