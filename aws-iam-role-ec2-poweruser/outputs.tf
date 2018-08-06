output "arn" {
  value = "${aws_iam_role.ec2-poweruser.arn}"
}

output "role_name" {
  value = "${aws_iam_role.ec2-poweruser.name}"
}
