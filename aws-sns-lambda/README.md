# AWS SNS to LAMBDA Integration
This module is for the integration of AWS SNS subscribing to lambda. It supports multiple SNS topics subscribing to lambda. The module references the [cztack/aws-lambda-function](https://github.com/chanzuckerberg/cztack/tree/main/aws-lambda-function) module for the lambda function.

## Example

```hcl
module aws-sns-lambda {
  source                  = "github.com/chanzuckerberg/cztack//aws-sns-lambda?ref=v0.36.0"
  env                     = local.env
  lambda_environment      = {
    "foob" : bar
  }
  lambda_function_name    = "lambda"
  lambda_handler          = "index.handler"
  lambda_runtime          = "nodejs12.x"
  lambda_source_code_hash = data.archive_file.lambda_archive.output_base64sha256
  lambda_timeout          = local.lambda_timeout
  lambda_zip_file         = data.archive_file.lambda_archive.output_path
  owner                   = var.owner
  project                 = var.project
  service                 = var.service
  sns_configurations      = [
    {
      topic_name : "...",
      topic_display_name : "...",
      endpoint_auto_confirms          : false
      confirmation_timeout_in_minutes : 1
    },
    {
      topic_name : "heroku-dyno",
      topic_display_name : null,
      endpoint_auto_confirms          : false
      confirmation_timeout_in_minutes : 1
    }
  ]
  publish_lambda          = true
  lambda_role_path        = "/service-role/"
  function_description    = "A lambda function..."

}

data "archive_file" "lambda_archive" {
  type        = "zip"
  source_file = "${path.module}/lambda_src/index.js"
  output_path = "${path.module}/lambda_src/lambda_build.zip"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | Env for tagging and naming. | `string` | n/a | yes |
| lambda_environment | Map of lambda environment variables. | `map(string)` | `{}` | no |
| function_deescription | Description for the lambda function. | string | "" | no |
| publish_lambda | Whether to publish creation/change as new Lambda Function Version. | bool | false | no |
| lambda_role_path | Path of the IAM role for lambda. If not specify, IAM will set the path to '/'.| string | null | no |
| lambda_handler | Name of the lambda handler. | string | n/a | yes | 
| lambda_runtime | Lambda language runtime. | string | n/a | yes |
| lambda_timeout | Execution timeout for the lambda. If null, defaults to 3 sec. | number | n/a | yes |
| lambda_source_code_hash | Lambda source code, used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file. | string | null | no |
| lambda_zip_file | The path to the function's deployment package within the local filesystem. | string | null | no |
| lambda_function_name | Name for lambda function. | string | null | no |
| log_retention_in_days | The number of days to retain log events in the log group for lambda. | number | null | no
| sns_configurations | List of objects containing the SNS configurations, list length equals the number of SNS topics created. | <pre>object(<br>    {<br>      topic_name : string,      <br>      topic_display_name : string, <br>      confirmation_timeout_in_minutes : string, <br>      endpoint_auto_confirms : string, <br>    }<br>  )</pre> | [] | no
| owner | Owner for tagging and naming. | `string` | n/a | yes |
| project | Project for tagging and naming. | `string` | n/a | yes |
| runtime | Lambda language runtime. | `string` | n/a | yes |
| service | Service for tagging and naming. | `string` | n/a | yes |


## Outputs

| Name | Description |
|------|-------------|
| lambda_role_name | Name of the IAM role for lambda. |
| sns_topics_arns | List of ARNs for the SNS topics creasted, depending on the length of sns_configurations. |

<!-- START -->
<!-- END -->