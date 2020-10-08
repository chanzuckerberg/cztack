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

  runtime     = var.runtime
  role        = aws_iam_role.role.arn
  timeout     = var.timeout
  kms_key_arn = var.kms_key_arn

  publish = var.publish

  dynamic environment {
    for_each = length(var.environment) > 0 ? [0] : []

    content {
      variables = var.environment
    }
  }

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
  name = local.name

  assume_role_policy = data.aws_iam_policy_document.lambda_role_policy.json

  tags = local.tags
}

resource aws_cloudwatch_log_group log {
  name              = "/aws/lambda/${local.name}"
  retention_in_days = var.log_retention_in_days
}

data aws_region current {}
data aws_caller_identity current {}

# TODO scope this policy down
#
# I would love to use "${aws_cloudwatch_log_group.log.arn}", as the
# resource here, but the provider returns an ARN that looks like:
#   arn:aws:logs:us-west-2:123456789:log-group:/foo/bar:*
# Unfortunately you need to use an ARN like:
#   arn:aws:logs:us-west-2:123456789:log-group:/foo/bar
# to match operations on the log group(like creating a new stream.) So instead we construct one
# without the colon before the *, so that we can match both log groups and log streams.
data aws_iam_policy_document lambda_logging_policy {
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
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.log.name}*",
    ]
  }
}

resource aws_iam_policy lambda_logging {
  name_prefix = "${local.name}-lambda-logging"
  path        = "/"
  description = "IAM policy for logging from the ${local.name} lambda."

  policy = data.aws_iam_policy_document.lambda_logging_policy.json
}

resource aws_iam_role_policy_attachment lambda_logs {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}
