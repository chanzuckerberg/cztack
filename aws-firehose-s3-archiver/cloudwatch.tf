data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "sender_assume_role" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "sender_role" {
  name               = "${var.name}-CloudwatchRole"
  assume_role_policy = data.aws_iam_policy_document.sender_assume_role.json
}

data "aws_iam_policy_document" "sender_policy" {
  version = "2012-10-17"
  statement {
    actions = [
      "logs:PutLogEvents",
    ]
    effect = "Allow"
    resources = [
      aws_kinesis_firehose_delivery_stream.s3_archiver.arn,
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*",
    ]
  }
  statement {
    actions = ["firehose:*"]
    effect  = "Allow"
    resources = [
      aws_kinesis_firehose_delivery_stream.s3_archiver.arn,
    ]
  }
  statement {
    actions = ["iam:PassRole"]
    effect  = "Allow"
    resources = [
      aws_iam_role.sender_role.arn,
    ]
  }
}

resource "aws_iam_role_policy" "kinesis_perms" {
  name   = "${var.name}-KinesisPolicy"
  role   = aws_iam_role.sender_role.id
  policy = data.aws_iam_policy_document.sender_policy.json
}

resource "aws_cloudwatch_log_subscription_filter" "cloudwatch_subscription_filter" {
  name            = var.name
  destination_arn = aws_kinesis_firehose_delivery_stream.s3_archiver.arn
  filter_pattern  = var.cloudwatch_filter_pattern
  log_group_name  = var.log_group_name
  role_arn        = aws_iam_role.sender_role.arn
  depends_on = [
    aws_kinesis_firehose_delivery_stream.s3_archiver,
  ]
}
