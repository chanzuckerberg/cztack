output "database_name" {
  value = module.aurora.database_name
  sensitive = false
}

output "master_username" {
  value = module.aurora.database_username
  sensitive = false
}

output "master_password" {
  value = module.aurora.database_password
  sensitive = true
}

output "endpoint" {
  value = module.aurora.endpoint
  sensitive = false
}

output "reader_endpoint" {
  value = module.aurora.reader_endpoint
  sensitive = false
}

output "port" {
  value = module.aurora.port
  sensitive = false
}

output "cluster_resource_id" {
  value = module.aurora.cluster_resource_id
  sensitive = false
}

output "cluster_id" {
  value = module.aurora.rds_cluster_id
  sensitive = false
}

output "aws_rds_cluster_instance" {
  value = module.aurora.aws_rds_cluster_instance.db
}
