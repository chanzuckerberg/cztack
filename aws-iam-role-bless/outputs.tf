output "role_name" {
  value = "${aws_iam_role.client.name}"
}

output "role_arn" {
  value = "${aws_iam_role.client.arn}"
}
