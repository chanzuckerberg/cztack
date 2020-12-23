output "primary_endpoint_address" {
  value = aws_elasticache_replication_group.default.primary_endpoint_address
}

output "configuration_endpoint_address" {
  value = aws_elasticache_replication_group.default.configuration_endpoint_address
}

output "port" {
  value = var.port
}
