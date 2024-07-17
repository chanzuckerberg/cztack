output "dbx_unity_aws_role_arn" {
  value = aws_iam_role.dbx_unity_aws_role.arn
}

output "volume_specific_bucket_name" {
  value = length(module.databricks_bucket) > 0 ? module.databricks_bucket[0].name : null
}

output "volume_path" {
  value = "${local.catalog_name}.${local.schema_name}.${local.volume_name}"
}