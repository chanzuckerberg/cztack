output "group_arn" {
  value = "${aws_iam_group.assume-role.arn}"
}

output "group_name" {
  value = "${aws_iam_group.assume-role.name}"
}
