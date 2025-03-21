output "dbx_unity_aws_role_arns" {
  value = values(aws_iam_role.dbx_unity_aws_role)[*].arn
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
