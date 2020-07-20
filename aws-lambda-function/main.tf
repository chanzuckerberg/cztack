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
  role        = var.role_arn
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
