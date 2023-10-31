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
