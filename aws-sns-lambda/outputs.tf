output lambda_role_name {
  value = module.lambda.role_name
}

output sns_topic_arns {
  value = {for key, sns in aws_sns_topic.sns: key => sns.arn}
}
