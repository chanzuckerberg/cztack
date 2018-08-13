output "arn" {
  value = "${aws_iam_role.poweruser.arn}"
}

output "role_name" {
  value = "${aws_iam_role.poweruser.name}"
}
