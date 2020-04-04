output "database_name" {
  value = aws_rds_cluster.db.database_name
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