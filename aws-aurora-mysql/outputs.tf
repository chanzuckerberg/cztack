output "database_name" {
  value = module.aurora.database_name
}

output "endpoint" {
  value = module.aurora.endpoint
}

output "reader_endpoint" {
  value = module.aurora.reader_endpoint
}

output "rds_cluster_id" {
  value = module.aurora.rds_cluster_id
}

output "db_parameter_group_name" {
  value = module.aurora.db_parameter_group_name
}