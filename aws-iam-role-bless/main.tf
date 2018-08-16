resource "aws_iam_role" "client" {
  name               = "${var.role_name}"
  path               = "${var.iam_path}"
  assume_role_policy = "${data.aws_iam_policy_document.client_assume_role.json}"
}

data "aws_iam_policy_document" "client_assume_role" {
  statement {
    sid     = "AssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "client" {
  statement {
    sid       = "Lambda"
    actions   = ["lambda:InvokeFunction"]
    resources = ["${var.bless_lambda_arns}"]
  }
}

resource "aws_iam_role_policy" "client" {
  name   = "lambda"
  role   = "${aws_iam_role.client.name}"
  policy = "${data.aws_iam_policy_document.client.json}"
}
