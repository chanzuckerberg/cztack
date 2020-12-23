output "primary_endpoint_address" {
  description = "The endpoint of the primary node in this node group (shard)."
  value       = aws_elasticache_replication_group.default.primary_endpoint_address
}

output "configuration_endpoint_address" {
  description = "The configuration endpoint address to allow host discovery."
  value       = aws_elasticache_replication_group.default.configuration_endpoint_address
}

output "port" {
  description = "Redis TCP port."
  value       = var.port
}
