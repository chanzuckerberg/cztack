output "role_name" {
  value = aws_iam_role.role.name
}

output "iam_path" {
  value = var.iam_path
}
