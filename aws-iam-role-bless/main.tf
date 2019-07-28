data "aws_iam_policy_document" "client" {
  statement {
    sid       = "Lambda"
    actions   = ["lambda:InvokeFunction"]
    resources = "${var.bless_lambda_arns}"
  }
}

resource "aws_iam_role_policy" "client" {
  name   = "lambda"
  role   = "${module.client.role_name}"
  policy = "${data.aws_iam_policy_document.client.json}"
}

module "client" {
  source = "../aws-iam-role-crossacct"

  role_name         = "${var.role_name}"
  iam_path          = "${var.iam_path}"
  source_account_id = "${var.source_account_id}"
}
