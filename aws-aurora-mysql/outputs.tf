output "database_name" {
  value = "${module.aurora.database_name}"
}

output "endpoint" {
  value = "${module.aurora.endpoint}"
}

output "reader_endpoint" {
  value = "${module.aurora.reader_endpoint}"
}
