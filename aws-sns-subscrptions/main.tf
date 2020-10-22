locals {
  tags = {
    managedBy = "terraform"
    env       = var.env
    owner     = var.owner
    service   = var.service
    project   = var.project
  }
}

resource aws_sns_topic sns {
  name = var.sns_topic_name == null ? "${var.project}-${var.env}-${var.service}" : var.sns_topic_name
  tags = local.tags
}

resource aws_sns_topic_subscription subscription {
  for_each                        = { for subscription in var.sns_subscriptions : subscription.endpoint => subscription }
  topic_arn                       = aws_sns_topic.sns.arn
  protocol                        = each.value.protocol
  confirmation_timeout_in_minutes = lookup(each.value, "confirmation_timeout_in_minutes", 1)
  endpoint                        = each.key
  endpoint_auto_confirms          = lookup(each.value, "endpoint_auto_confirms", true)
}
