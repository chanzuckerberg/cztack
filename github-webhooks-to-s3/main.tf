locals {
  name = "${var.project}-${var.env}-${var.service}"

  tags = {
    managedBy = "terraform"
    Name      = local.name
    env       =  var.env
    owner     =  var.owner
    service   =  var.service
    owner     =  var.owner
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "EnableLambdaAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "firehose-write" {
  statement {
    effect = "Allow"

    actions = [
      "firehose:PutRecord",
    ]

    resources = ["${aws_kinesis_firehose_delivery_stream.firehose.arn}"]
  }
}

resource "aws_iam_role_policy" "firehose" {
  name   = "firehose"
  role   =  aws_iam_role.lambda.id
  policy =  data.aws_iam_policy_document.firehose-write.json
}

module "attach-logs" {
  source    = "../aws-iam-policy-cwlogs"
  role_name =  aws_iam_role.lambda.name
  iam_path  =  var.iam_path
}

resource "aws_iam_role" "lambda" {
  name               = local.name
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = local.tags
}

module "github_secret" {
  source  = "../aws-param"
  project =  var.project
  env     =  var.env
  service =  var.service
  name    = "github_secret"
}

resource "aws_lambda_function" "lambda" {
  s3_bucket =  var.lambda_source_s3_bucket
  s3_key    =  var.lambda_source_s3_key

  function_name =  local.name
  handler       = "handler"

  runtime = "go1.x"
  role    =  aws_iam_role.lambda.arn
  timeout = 20
  tags    =  local.tags

  environment {
    variables = {
      FIREHOSE_DELIVERY_STREAM =  local.name
      GITHUB_SECRET            =  module.github_secret.value
    }
  }
}
