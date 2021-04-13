locals {
  default_sns_name = "${var.project}-${var.env}-${var.service}"
  # If there is only one SNS config, and topic_name is not provided, then use default topic name, 
  # otherwise, the SNS config without the topic_name will be discarded.
  valid_sns_configs = length(var.sns_configurations) == 1 ? [
    {
      topic_name                      = lookup(var.sns_configurations[0], "topic_name", local.default_sns_name)
      topic_display_name              = lookup(var.sns_configurations[0], "topic_display_name", null)
      confirmation_timeout_in_minutes = lookup(var.sns_configurations[0], "confirmation_timeout_in_minutes", null)
      endpoint_auto_confirms          = lookup(var.sns_configurations[0], "endpoint_auto_confirms", null)
    }
    ] : [
    for sns_config in var.sns_configurations : {
      topic_name                      = lookup(sns_config, "topic_name", null)
      topic_display_name              = lookup(sns_config, "topic_display_name", null)
      confirmation_timeout_in_minutes = lookup(sns_config, "confirmation_timeout_in_minutes", null)
      endpoint_auto_confirms          = lookup(sns_config, "endpoint_auto_confirms", null)
    } if(lookup(sns_config, "topic_name", null) != null)
  ]
}

resource "aws_sns_topic" "sns" {
  for_each     = { for sns_config in local.valid_sns_configs : sns_config.topic_name => sns_config }
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

resource "aws_sns_topic_subscription" "sns_subscription" {
  for_each                        = { for sns_config in local.valid_sns_configs : sns_config.topic_name => sns_config }
  topic_arn                       = aws_sns_topic.sns[each.value.topic_name].arn
  confirmation_timeout_in_minutes = each.value.confirmation_timeout_in_minutes
  endpoint_auto_confirms          = each.value.endpoint_auto_confirms
  protocol                        = "lambda"
  endpoint                        = module.lambda.arn
}
