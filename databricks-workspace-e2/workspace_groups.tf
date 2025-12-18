# Groups for workspace - managing access via Unified Login

resource "databricks_group" "workspace_users" {
  display_name                   = "workspace-${var.project}-${var.env}-users"
}

resource "databricks_group" "workspace_admins" {
  display_name                   = "workspace-${var.project}-${var.env}-admins"
}

resource "databricks_mws_permission_assignment" "workspace_users" {
  workspace_id = databricks_mws_workspaces.databricks.workspace_id
  principal_id = databricks_group.workspace_users.id
  permissions  = ["USER"]
}

resource "databricks_mws_permission_assignment" "workspace_admins" {
  workspace_id = databricks_mws_workspaces.databricks.workspace_id
  principal_id = databricks_group.workspace_admins.id
  permissions  = ["ADMIN"]
}

resource "databricks_group_member" "workspace_users" {
  for_each   = toset(var.workspace_users)
  group_id   = databricks_group.workspace_users.id
  member_id  = each.value
}

resource "databricks_group_member" "workspace_admins" {
  for_each   = toset(var.workspace_admins)
  group_id   = databricks_group.workspace_admins.id
  member_id  = each.value
}