# AWS Lambda Function

## Example

```hcl
module lambda {
  source = "github.com/chanzuckerberg/cztack/aws-lambda-function?ref=v0.14.0"

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
| aws | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| at\_edge | Is this lambda going to be used with a Cloufront distribution? If you set this, you will not have control over log retention, and you cannot include environment variables. | `bool` | `false` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| environment | Map of environment variables. | `map(string)` | `{}` | no |
| filename | n/a | `string` | `null` | no |
| function\_description | Description for lambda function. | `string` | `""` | no |
| function\_name | If not set, function use default naming convention of $project-$env-$service. See local.name in main.tf | `string` | `null` | no |
| handler | Name of the lambda handler. | `string` | n/a | yes |
| kms\_key\_arn | KMS key used to encrypt environment variables. | `string` | `null` | no |
| lambda\_role\_path | The path to the IAM role for lambda. | `string` | `null` | no |
| log\_retention\_in\_days | n/a | `number` | `null` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| publish\_lambda | Whether to publish creation/change as new lambda function version. | `bool` | `false` | no |
| runtime | Lambda language runtime. | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| source\_code\_hash | n/a | `string` | `null` | no |
| source\_s3\_bucket | Bucket holding lambda source code. | `string` | `null` | no |
| source\_s3\_key | Key identifying location of code. | `string` | `null` | no |
| timeout | Execution timeout for the lambda. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| function\_name | n/a |
| invoke\_arn | n/a |
| log\_group\_name | n/a |
| qualified\_arn | If the lambda function is published, the qualified\_arn points at the latest version number. |
| role\_id | n/a |
| role\_name | n/a |

<!-- END -->
