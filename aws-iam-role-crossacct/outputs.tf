output "role_name" {
  value = aws_iam_role.role.name
}

output "role_arn" {
  value = aws_iam_role.role.arn
}

output "iam_path" {
  value = var.iam_path
}
