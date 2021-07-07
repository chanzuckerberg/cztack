terraform {
  required_providers {
    # Depends on aws_cloudwatch_log_group.log.arn not returning trailing ":*" starting in 3.0.0
    aws = ">= 3.0.0"
  }
}
