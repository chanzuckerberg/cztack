locals {
  name = var.function_name != null ? var.function_name : "${var.project}-${var.env}-${var.service}"

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
  description   = var.function_description
  publish       = var.publish_lambda

  runtime     = var.runtime
  role        = aws_iam_role.role.arn
  timeout     = var.timeout
  kms_key_arn = var.kms_key_arn

  reserved_concurrent_executions = var.reserved_concurrent_executions

  dynamic "environment" {
    for_each = length(var.environment) > 0 ? [0] : []

    content {
      variables = var.environment
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config == null ? [] : [0]

    content {
      subnet_ids         = var.vpc_config.subnet_ids
      security_group_ids = var.vpc_config.security_group_ids
    }
  }

  memory_size = var.memory_size

  tags = local.tags
}

data aws_iam_policy_document lambda_role_policy {
  statement {
    principals {
      type = "Service"
      identifiers = compact([
        "lambda.amazonaws.com",
        var.at_edge ? "edgelambda.amazonaws.com" : ""
      ])
    }
    actions = ["sts:AssumeRole"]
  }
}

resource aws_iam_role role {
  name               = local.name
  path               = var.lambda_role_path
  assume_role_policy = data.aws_iam_policy_document.lambda_role_policy.json
  tags               = local.tags
}

resource "aws_cloudwatch_log_group" "log" {
  name              = "/aws/lambda/${local.name}"
  retention_in_days = var.log_retention_in_days
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# TODO scope this policy down
data "aws_iam_policy_document" "lambda_logging_policy" {
  statement {
    effect = "Allow"
    actions = compact([
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      var.at_edge ? "logs:CreateLogGroup" : ""
    ])

    resources = [
      var.at_edge ?
      "*" :
      "${aws_cloudwatch_log_group.log.arn}:*"
    ]
  }
}

resource "aws_iam_policy" "lambda_logging" {
  name_prefix = "${local.name}-lambda-logging"
  path        = "/"
  description = "IAM policy for logging from the ${local.name} lambda."
  policy      = data.aws_iam_policy_document.lambda_logging_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

// Execution role basic permissions
data "aws_iam_policy_document" "role" {
  statement {
    sid    = "ec2"
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role_policy" "role" {
  role   = aws_iam_role.role.name
  policy = data.aws_iam_policy_document.role.json
}
