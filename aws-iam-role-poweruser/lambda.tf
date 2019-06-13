
locals {
  enable_lambda = "${var.enable_lambda ? 1 : 0}"

}
// Readonly everywhere
resource "aws_iam_role_policy_attachment" "lambda-readonly" {
  role       = "${aws_iam_role.poweruser.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaReadOnlyAccess"
}


// Write confined to regions
// adapted from arn:aws:iam::aws:policy/AWSLambdaFullAccess
data "aws_iam_policy_document" "lambda-write-regional" {
  statement {
    sid = "lambdaWriteRegional"
    actions = [
      "lambda:*",

      // TODO: what to do about these
      "cloudwatch:*",
      "events:*",
      "logs:*",
      "sns:ListSubscriptions",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTopics",
      "sns:Publish",
      "sns:Subscribe",
      "sns:Unsubscribe",
      "sqs:ListQueues",
      "sqs:SendMessage",
      "tag:GetResources",
      "xray:PutTelemetryRecords",
      "xray:PutTraceSegments"
    ]
    resources = ["*"]
    // HACK: I wish I could conditionally assign this block but don't know how to do it in terraform
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["${var.authorized_regions}"]
    }
  }
}

resource "aws_iam_role_policy" "lambda-write-regional" {
  count  = "${local.enable_lambda * local.all_regions_disabled}"
  name   = "lambda-write-regional"
  policy = "${data.aws_iam_policy_document.lambda-write-regional.json}"
}

resource "aws_iam_role_policy_attachment" "lambda-write-all-regions" {
  count      = "${local.enable_lambda * local.all_regions_enabled}"
  role       = "${aws_iam_role.poweruser.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
}
