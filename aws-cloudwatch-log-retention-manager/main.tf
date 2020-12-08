locals {
  tags = {
    managedBy = "terraform"
    env       = var.env
    project   = var.project
    service   = var.service
    owner     = var.owner
  }

  lambda_name = "${var.project}-${var.env}-${var.service}-cloudwatch-retention"
}

data archive_file lambda {
  type        = "zip"
  output_path = "${path.module}/build/lambda.zip"
  source {
    filename = "function.rb"
    content  = <<-EOF
      require 'aws-sdk-ec2'
      require 'aws-sdk-cloudwatchlogs'
      MAXIMUM_RETENTION = ${var.maximum_retention}

      def handler(event:, context:)
        regions = Aws::EC2::Client.new.describe_regions.regions.map(&:region_name)
        regions.each do |region|
          puts "Processing Region: #{region}"
          cloudwatch = Aws::CloudWatchLogs::Client.new(region: region)
          cloudwatch.describe_log_groups.each do |log_group_batch|
            log_group_batch.log_groups.each do |log_group|
              name = log_group.log_group_name
              retention = log_group.retention_in_days

              print "Region: #{region}, LogGroup: #{name}, Retention: #{retention || 'None'}, "

              # If retention is set, and less than the required maximum, skip.
              if retention && retention <= MAXIMUM_RETENTION
                print "Result: Compliant\n"
                next
              end

              # Specific log groups may be exempt from the maximum retention policy.
              tags = cloudwatch.list_tags_log_group(log_group_name: log_group.log_group_name).tags
              exempt = tags["ExemptFromMaxRetentionPolicy"] == "true"
              if exempt
                print "Result: Exempt\n"
                next
              end

              # Add or replace existing retention to match policy.
              cloudwatch.put_retention_policy(
                log_group_name: log_group.log_group_name,
                retention_in_days: DEFAUT_MAX_RETENTION
              )
              print "Result: Fixed\n"
            end
          end
        end
      end
    EOF
  }
}

module lambda {
  source = "../aws-lambda-function"

  function_name    = local.lambda_name
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
  handler          = "function.handler"
  runtime          = "ruby2.7"

  timeout               = 300
  log_retention_in_days = var.maximum_retention

  env     = var.env
  owner   = var.owner
  project = var.project
  service = var.service
}

resource aws_cloudwatch_event_rule trigger {
  name                = "${var.project}-${var.env}-${var.service}-retention-trigger"
  schedule_expression = "rate(5 minutes)"
  tags                = local.tags
}

resource aws_cloudwatch_event_target trigger {
  rule = aws_cloudwatch_event_rule.trigger.id
  arn  = module.lambda.arn
}

resource aws_lambda_permission permission {
  statement_id  = "AllowScheduledLambdaExecution"
  action        = "lambda:InvokeFunction"
  function_name = local.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.trigger.arn
}

data aws_iam_policy_document policy {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeRegions",
      "logs:DescribeLogGroups",
      "logs:ListTagsLogGroup",
      "logs:PutRetentionPolicy",
    ]
    resources = ["*"]
  }
}

resource aws_iam_role_policy policy {
  name   = "allow-managing-log-groups"
  role   = module.lambda.role_id
  policy = data.aws_iam_policy_document.policy.json
}
