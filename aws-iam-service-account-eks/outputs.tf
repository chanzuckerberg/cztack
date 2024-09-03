output "iam_role_name_with_path" {
  value = "${substr(local.iam_path, 1, -1)}${aws_iam_role.role.name}"
}

output "iam_role" {
  value = aws_iam_role.role.name
}

output "iam_role_arn" {
  value = aws_iam_role.role.arn
}

output "service_account_name" {
  value = kubernetes_service_account.service_account.metadata[0].name
}