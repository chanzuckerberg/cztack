module lambda {
  source               = "github.com/chanzuckerberg/cztack//aws-lambda-function?ref=c4e30cc70990c8b380d5da4f38480fe3a9d8a9bc"
  environment          = var.lambda_environment
  function_description = var.function_description
  function_name        = var.lambda_function_name
  filename             = var.lambda_zip_file
  handler              = var.lambda_handler
  source_code_hash     = var.lambda_source_code_hash
  runtime              = var.lambda_runtime
  timeout              = var.lambda_timeout
  publish_lambda       = var.publish_lambda
  lambda_role_path     = var.lambda_role_path

  project = var.project
  env     = var.env
  service = var.service
  owner   = var.owner
}
