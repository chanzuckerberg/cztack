output arn {
  value = aws_lambda_function.lambda.arn
}

output invoke_arn {
  value = aws_lambda_function.lambda.invoke_arn
}

output role_name {
  value = aws_iam_role.role.name
}

output log_group_name {
  value = aws_cloudwatch_log_group.log.name
}
