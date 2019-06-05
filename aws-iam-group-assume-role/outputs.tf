output "group_arn" {
  value = "${aws_iam_group.assume-role.arn}"
}

output "group_name" {
  value = "${aws_iam_group.assume-role.name}"
}

# # https://github.com/hashicorp/terraform/issues/1178
# output "depended_on" {
#   value = "${null_resource.dependency_setter.id}"
# }

