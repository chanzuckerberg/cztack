locals {
  name = "${var.project}-${var.env}-${var.service}"

  tags = {
    managedBy = "terraform"
    Name      = local.name
    env       = var.env
    owner     = var.owner
    service   = var.service
    owner     = var.owner
  }
}


resource aws_lambda_function lambda {
  s3_bucket = var.source_s3_bucket
  s3_key    = var.source_s3_key

  filename         = var.filename
  source_code_hash = var.source_code_hash

  function_name = local.name
  handler       = var.handler

  runtime     = var.runtime
  role        = aws_iam_role.role.arn
  timeout     = var.timeout
  kms_key_arn = var.kms_key_arn

  dynamic environment {
    for_each = length(var.environment) > 0 ? [0] : []

    content {
      variables = var.environment
    }
  }

  tags = local.tags
}


resource aws_iam_role role {
  name = local.name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = local.tags
}

resource aws_cloudwatch_log_group log {
  name              = "/aws/lambda/${local.name}"
  retention_in_days = 14
}

resource aws_iam_policy lambda_logging {
  name_prefix = "${local.name}-lambda-logging"
  path        = "/"
  description = "IAM policy for logging from the ${local.name} lambda."

  # TODO scope this policy down
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource aws_iam_role_policy_attachment lambda_logs {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}
