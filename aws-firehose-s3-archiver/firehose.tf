data "aws_iam_policy_document" "firehose_assume_role" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "firehose_to_s3" {
  name               = "${var.name}-FirehoseRole"
  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
}

data "aws_iam_policy_document" "firehose_policy" {
  version = "2012-10-17"
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*",
    ]
  }
}

resource "aws_iam_role_policy" "firehose" {
  name   = "${var.name}-FirehosePolicy"
  role   = aws_iam_role.firehose_to_s3.id
  policy = data.aws_iam_policy_document.firehose_policy.json
}

resource "aws_kinesis_firehose_delivery_stream" "s3_archiver" {
  name        = var.name
  destination = "extended_s3"
  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_to_s3.arn
    bucket_arn = "arn:aws:s3:::${var.bucket_name}"
    prefix     = var.s3_prefix
    # Data from Cloudwatch Logs are already compressed with gzip level 6 compression
    #   https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/SubscriptionFilters.html#FirehoseExample
    file_extension = ".gz"
    s3_backup_mode = var.enable_backup ? "Enabled" : "Disabled"
    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = "/aws/kinesisfirehose/${var.name}"
      log_stream_name = "DestinationDelivery"
    }
    dynamic "s3_backup_configuration" {
      for_each = var.enable_backup ? [true] : []
      content {
        role_arn            = aws_iam_role.firehose_to_s3.arn
        bucket_arn          = "arn:aws:s3:::${var.bucket_name}"
        error_output_prefix = "errors/${var.s3_prefix}!{firehose:error-output-type}/"
        prefix              = "${var.s3_prefix}raw/"
        cloudwatch_logging_options {
          enabled         = true
          log_group_name  = "/aws/kinesisfirehose/${var.name}"
          log_stream_name = "BackupDelivery"
        }
      }
    }
  }
}
