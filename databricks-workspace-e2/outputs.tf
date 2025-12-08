output "workspace_id" {
  description = "ID of the workspace."
  value       = databricks_mws_workspaces.databricks.workspace_id
}

output "workspace_url" {
  description = "Url of the deployed workspace."
  value       = databricks_mws_workspaces.databricks.workspace_url
}

output "role_arn" {
  description = "ARN of the AWS IAM role."
  value       = aws_iam_role.databricks.arn
}

output "workspace_users_group_id" {
  description = "ID of the workspace users group."
  value       = databricks_group.workspace_users.id
}

output "workspace_admins_group_id" {
  description = "ID of the workspace admins group."
  value       = databricks_group.workspace_admins.id
}