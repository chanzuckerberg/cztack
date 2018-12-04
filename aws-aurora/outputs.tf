output "database_name" {
  value = "${aws_rds_cluster.db.database_name}"
}

output "endpoint" {
  value = "${aws_rds_cluster.db.endpoint}"
}

output "reader_endpoint" {
  value = "${aws_rds_cluster.db.reader_endpoint}"
}

output "port" {
  value = "${var.port}"
}
