output arn {
  value = aws_lambda_function.lambda.arn
}

output qualified_arn {
  description = "If the lambda function is published, the qualified_arn points at the latest version number."
  value       = aws_lambda_function.lambda.qualified_arn
}

output invoke_arn {
  value = aws_lambda_function.lambda.invoke_arn
}

output function_name {
  value = aws_lambda_function.lambda.function_name
}

output log_group_name {
  value = aws_cloudwatch_log_group.log.name
}

output role_name {
  value = aws_iam_role.role.name
}

output role_id {
  value = aws_iam_role.role.id
}
