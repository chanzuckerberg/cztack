output "database_name" {
  value = "${module.aurora.database_name}"
}

output "endpoint" {
  value = "${module.aurora.endpoint}"
}

output "port" {
  value = "${module.aurora.port}"
}
