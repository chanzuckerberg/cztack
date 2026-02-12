locals {
  vpc_flow_logs_cloudwatch_group_name = substr("${var.project}-${var.env}-${var.service}-vpc-flow-logs", 0, 63)

  // HACK(el): Adding this here and not as a variable since fogg source_modules
  //           will override defaults
  s3_vpc_flow_collection_bucket = "arn:aws:s3:::shared-infra-prod-vpc-logs"
}

resource "aws_flow_log" "vpc_flow_logs" {
  log_destination = aws_cloudwatch_log_group.vpc.arn
  iam_role_arn    = aws_iam_role.vpc_flow_logs.arn
  vpc_id          = module.vpc.vpc_id
  traffic_type    = "ALL"
}

resource "aws_flow_log" "s3_vpc_flow_logs" {
  log_destination      = local.s3_vpc_flow_collection_bucket
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = module.vpc.vpc_id
}

resource "aws_cloudwatch_log_group" "vpc" {
  name = local.vpc_flow_logs_cloudwatch_group_name

  retention_in_days = var.vpc_flow_log_retention_in_days

  tags = local.tags
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "vpc_flow_logs" {
  name               = substr("${var.project}-${var.env}-${var.service}-flow-logs", 0, 63)
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = local.tags
}

data "aws_iam_policy_document" "vpc_flow_logs" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "vpc_flow_logs" {
  name   = local.vpc_flow_logs_cloudwatch_group_name
  role   = aws_iam_role.vpc_flow_logs.id
  policy = data.aws_iam_policy_document.vpc_flow_logs.json
}
