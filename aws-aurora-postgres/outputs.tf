output "database_name" {
  value = module.aurora.database_name
}

output "master_username" {
  value = module.aurora.database_username
}

output "master_password" {
  value = module.aurora.database_password
}

output "endpoint" {
  value = module.aurora.endpoint
}

output "reader_endpoint" {
  value = module.aurora.reader_endpoint
}

output "port" {
  value = module.aurora.port
}
