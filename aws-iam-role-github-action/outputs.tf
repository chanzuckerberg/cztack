output "role" {
  value = {
    name = aws_iam_role.role.name
    arn  = aws_iam_role.role.arn
  }
}
