output "arn" {
  value = "${aws_cloudwatch_log_group.group.arn}"
}

output "name" {
  value = "${local.log_group_name}"
}
