output "dbx_unity_aws_role_arn" {
  value = length(aws_iam_role.dbx_unity_aws_role) > 0 ? aws_iam_role.dbx_unity_aws_role[0].arn : null
}

output "volume_specific_bucket_name" {
  value = length(module.databricks_bucket) > 0 ? module.databricks_bucket[0].name : null
}

output "volume_path" {
  value = "${local.catalog_name}.${local.schema_name}.${local.volume_name}"
}

output "catalog_name" {
  value = local.catalog_name
}

output "schema_name" {
  value = local.schema_name
}

output "volume_name" {
  value = local.volume_name
}