output "database_name" {
  value = "${aws_rds_cluster.db.database_name}"
}

output "endpoint" {
  value = "${aws_rds_cluster.db.endpoint}"
}

output "port" {
  value = "${var.port}"
}
