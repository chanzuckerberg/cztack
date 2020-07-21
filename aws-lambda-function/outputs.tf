output arn {
  value = aws_lambda_function.lambda.arn
}

output invoke_arn {
  value = aws_lambda_function.lambda.invoke_arn
}

output role_name {
  value = aws_iam_role.role.name
}
