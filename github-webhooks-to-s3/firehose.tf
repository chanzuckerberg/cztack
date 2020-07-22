module "bucket" {
  source = "../aws-s3-private-bucket"

  bucket_name   = local.name
  bucket_policy = ""

  project = var.project
  env     = var.env
  service = var.service
  owner   = var.owner
}

data "aws_iam_policy_document" "firehose" {
  statement {
    sid     = "EnableFirehoseAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "firehose" {
  name = "${local.name}-firehose"

  assume_role_policy = data.aws_iam_policy_document.firehose.json
  tags               = local.tags
}

data "aws_iam_policy_document" "firehose-to-s3" {
  statement {
    effect = "Allow"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]

    resources = [
      "${module.bucket.arn}",
      "${module.bucket.arn}/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
    ]

    resources = [
      "${aws_cloudwatch_log_group.firehose.arn}",
      "${aws_cloudwatch_log_group.firehose.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "firehose-s3" {
  name   = "firehose-s3"
  role   = aws_iam_role.firehose.id
  policy = data.aws_iam_policy_document.firehose-to-s3.json
}

resource "aws_kinesis_firehose_delivery_stream" "firehose" {
  name        = local.name
  destination = "s3"

  s3_configuration {
    role_arn           = aws_iam_role.firehose.arn
    bucket_arn         = module.bucket.arn
    prefix             = var.s3_prefix
    compression_format = "GZIP"

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.firehose.name
      log_stream_name = aws_cloudwatch_log_stream.firehose.name
    }
  }

  tags = local.tags
}

resource "aws_cloudwatch_log_group" "firehose" {
  name = "${local.name}-firehose"
  tags = local.tags
}

resource "aws_cloudwatch_log_stream" "firehose" {
  name           = "status"
  log_group_name = aws_cloudwatch_log_group.firehose.name
}
