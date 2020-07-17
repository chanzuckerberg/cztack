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


resource "aws_lambda_function" "lambda" {
  s3_bucket = var.source_s3_bucket
  s3_key    = var.source_s3_key

  function_name = local.name
  handler       = var.handler

  runtime = var.runtime
  role    = var.role_arn
  timeout = var.timeout
  tags    = local.tags

  environment {
    variables = var.environment
  }
}
