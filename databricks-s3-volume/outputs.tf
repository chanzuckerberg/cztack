output "dbx_unity_aws_role_arns" {
  value = { value = length(aws_iam_role.dbx_unity_aws_role) > 0 ? aws_iam_role.dbx_unity_aws_role[0].arn : null }
}

output "volume_bucket_name" {
  value = local.volume_bucket_name
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

output "catalog_groups" {
  description = "Catalog group names keyed by tier code. Empty unless create_catalog is true"
  value       = { for code, group in databricks_group.catalog : code => group.display_name }
}

output "schema_groups" {
  description = "Schema group names keyed by tier code. Empty unless create_schema is true"
  value       = { for code, group in databricks_group.schema : code => group.display_name }
}

output "volume_groups" {
  description = "Volume group names keyed by tier code"
  value       = { for code, group in databricks_group.volume : code => group.display_name }
}
