output "address" {
  value = aws_elasticache_cluster.default.cache_nodes.0.address
}

output "port" {
  value = var.port
}
