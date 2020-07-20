// https://learn.hashicorp.com/terraform/aws/lambda-api-gateway
resource "aws_api_gateway_rest_api" "github" {
  name        = local.name
  description = "Github webhook ingestion"
}

resource "aws_api_gateway_resource" "github" {
  rest_api_id = aws_api_gateway_rest_api.github.id
  parent_id   = aws_api_gateway_rest_api.github.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "github" {
  rest_api_id   = aws_api_gateway_rest_api.github.id
  resource_id   = aws_api_gateway_resource.github.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.github.id
  resource_id = aws_api_gateway_method.github.resource_id
  http_method = aws_api_gateway_method.github.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}

resource "aws_api_gateway_method" "github_root" {
  rest_api_id   = aws_api_gateway_rest_api.github.id
  resource_id   = aws_api_gateway_rest_api.github.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = aws_api_gateway_rest_api.github.id
  resource_id = aws_api_gateway_method.github_root.resource_id
  http_method = aws_api_gateway_method.github_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "github" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = aws_api_gateway_rest_api.github.id
  stage_name  = var.env
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.github.execution_arn}/*/*"
}
