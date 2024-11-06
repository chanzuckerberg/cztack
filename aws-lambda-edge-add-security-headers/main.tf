data "archive_file" "lambda" {
  type        = "zip"
  output_path = "${path.module}/build/lambda.zip"
  source {
    filename = "index.js"
    content  = <<-EOF
      exports.handler = async (event, context) => {
        const { response } = event.Records[0].cf;
        response.headers["strict-transport-security"] = [
          { value: "max-age=31536000; includeSubDomains; preload" },
        ];
        return response;
      };
    EOF
  }
}

module "lambda" {
  source = "../aws-lambda-function"

  function_name         = var.function_name != null ? var.function_name : replace("${var.project}-${var.env}-${var.service}-security-headers", ".", "-")
  filename              = data.archive_file.lambda.output_path
  source_code_hash      = data.archive_file.lambda.output_base64sha256
  handler               = "index.handler"
  runtime               = "nodejs18.x"
  at_edge               = true
  publish_lambda        = true
  log_retention_in_days = var.lambda_cloudwatch_log_retention_in_days

  env     = var.env
  owner   = var.owner
  project = var.project
  service = var.service
}
