output role_name {
  value       = aws_iam_role.role.id
  description = "IAM role name."
}

output role_arn {
  value       = aws_iam_role.role.arn
  description = "IAM role ARN."
}
