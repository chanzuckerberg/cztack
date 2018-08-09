output "database_name" {
  value = "${aws_rds_cluster.db.database_name}"
}

output "database_username" {
  value = "${var.database_username}"
}

output "database_password" {
  value = "${var.database_password}"
}

output "database_port" {
  value = "${var.database_port}"
}

output "endpoint" {
  value = "${aws_rds_cluster.db.endpoint}"
}
