locals {
  default_sns_name = "${var.project}-${var.env}-${var.service}"
}

resource aws_sns_topic sns {
  for_each     = { for sns_config in var.sns_configurations : sns_config.topic_name => sns_config }
  name         = each.value.topic_name == null ? local.default_sns_name : each.value.topic_name
  display_name = each.value.topic_display_name
  tags = {
    managedBy = "terraform"
    env       = var.env
    owner     = var.owner
    service   = var.service
    owner     = var.owner
  }
}

resource aws_sns_topic_subscription sns_subscription {
  for_each                        = { for sns_config in var.sns_configurations : sns_config.topic_name => sns_config }
  topic_arn                       = aws_sns_topic.sns[each.value.topic_name].arn
  confirmation_timeout_in_minutes = each.value.confirmation_timeout_in_minutes
  endpoint_auto_confirms          = each.value.endpoint_auto_confirms
  protocol                        = "lambda"
  endpoint                        = module.lambda.arn
}
