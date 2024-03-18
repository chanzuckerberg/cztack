output "database_name" {
  value = aws_rds_cluster.db.database_name
}

output "database_username" {
  value = var.database_username
}

output "database_password" {
  value = var.database_password
}

output "endpoint" {
  value = aws_rds_cluster.db.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.db.reader_endpoint
}

output "port" {
  value = var.port
}

output "rds_cluster_id" {
  value = aws_rds_cluster.db.id
}

output "db_parameter_group_name" {
  value = aws_db_parameter_group.db.name
}

output "cluster_resource_id" {
  value = aws_rds_cluster.db.cluster_resource_id
}

output "aws_rds_cluster_instance_endpoint" {
  value = aws_rds_cluster_instance.db[0].endpoint
}
