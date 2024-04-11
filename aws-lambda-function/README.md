# AWS Lambda Function

## Example

```hcl
module lambda {
  source = "github.com/chanzuckerberg/cztack/aws-lambda-function?ref=tf-aws-3.0"

  filename         = "file.zip"
  handler          = "handle"
  source_code_hash = base64(hash("file.zip"))
  runtime          = "python3.6"
  timeout          = 10

  project = var.project
  env     = var.env
  service = var.service
  owner   = var.owner
}
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambda_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.lambda_logging_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_at_edge"></a> [at\_edge](#input\_at\_edge) | Is this lambda going to be used with a Cloufront distribution? If you set this, you will not have control over log retention, and you cannot include environment variables. | `bool` | `false` | no |
| <a name="input_datadog_enabled"></a> [datadog\_enabled](#input\_datadog\_enabled) | Indicates if Datadog integration is enabled (see https://www.datadoghq.com/blog/monitoring-aws-lambda-with-datadog/ for details). | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Map of environment variables. | `map(string)` | `{}` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | n/a | `string` | `null` | no |
| <a name="input_function_description"></a> [function\_description](#input\_function\_description) | Description for lambda function. | `string` | `""` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | If not set, function use default naming convention of $project-$env-$service. See local.name in main.tf | `string` | `null` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Name of the lambda handler. | `string` | n/a | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS key used to encrypt environment variables. | `string` | `null` | no |
| <a name="input_lambda_role_path"></a> [lambda\_role\_path](#input\_lambda\_role\_path) | The path to the IAM role for lambda. | `string` | `null` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | n/a | `number` | `null` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Amount of memory to allocate to the lambda | `number` | `128` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_publish_lambda"></a> [publish\_lambda](#input\_publish\_lambda) | Whether to publish creation/change as new lambda function version. | `bool` | `false` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | Set reserved\_concurrent\_executions for this function. See [docs](https://docs.aws.amazon.com/lambda/latest/dg/configuration-concurrency.html). | `number` | `-1` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda language runtime. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_source_code_hash"></a> [source\_code\_hash](#input\_source\_code\_hash) | n/a | `string` | `null` | no |
| <a name="input_source_s3_bucket"></a> [source\_s3\_bucket](#input\_source\_s3\_bucket) | Bucket holding lambda source code. | `string` | `null` | no |
| <a name="input_source_s3_key"></a> [source\_s3\_key](#input\_source\_s3\_key) | Key identifying location of code. | `string` | `null` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Execution timeout for the lambda. | `number` | `null` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | The lambda's vpc configuration | <pre>object({<br>    subnet_ids         = list(string),<br>    security_group_ids = list(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | n/a |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | n/a |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | n/a |
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | If the lambda function is published, the qualified\_arn points at the latest version number. |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | n/a |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
<!-- END -->
