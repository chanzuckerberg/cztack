output "default_logging_role_arn" {
  description = "ARN of the AWS IAM role created for default logs access"
  value       = aws_iam_role.cluster_log_cluster_role.arn
}

output "rw_logging_role_arn" {
  description = "ARN of the AWS IAM role created for read and write logs access"
  value       = one(aws_iam_role.cluster_log_rw_role[*].arn)
}

output "rw_logging_role_instance_profile_arn" {
  description = "ARN of the AWS instance profile created for read and write logs access"
  value       = one(aws_iam_instance_profile.cluster_log_cluster_rw[*].arn)
}

output "dbx_instance_profile_id"{
  description = "ID of the Databricks instance profile created for writing logs"
  value       = databricks_instance_profile.cluster_log_cluster.id
}