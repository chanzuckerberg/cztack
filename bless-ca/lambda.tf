locals {
  lambda_zip_file = "/tmp/${random_id.path.b64_url}_bless_lambda.zip"
}

resource "random_id" "path" {
  byte_length = 8
}

data "bless_lambda" "code" {
  kmsauth_key_id                = aws_kms_key.bless_kms_auth.key_id
  encrypted_password            = bless_ca.bless.encrypted_password
  encrypted_ca                  = bless_ca.bless.encrypted_ca
  service_name                  = local.name
  output_path                   = local.lambda_zip_file
  logging_level                 = var.bless_logging_level
  kmsauth_iam_group_name_format = var.kmsauth_iam_group_name_format
}

module "lambda" {
  source = "../aws-lambda-function"

  filename         = local.lambda_zip_file
  handler          = "bless_lambda.lambda_handler"
  source_code_hash = data.bless_lambda.code.output_base64sha256
  runtime          = "python3.6"
  kms_key_arn      = aws_kms_key.bless.arn
  timeout          = 10

  project = var.project
  env     = var.env
  service = var.service
  owner   = var.owner
}
