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

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| environment | Map of environment variables. | `map(string)` | `{}` | no |
| filename | n/a | `string` | `null` | no |
| handler | Name of the lambda handler. | `string` | n/a | yes |
| kms\_key\_arn | KMS key used to encrypt environment variables. | `string` | `null` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| role\_arn | AWS IAM Role the lambda should use. | `string` | n/a | yes |
| runtime | Lambda language runtime. | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| source\_code\_hash | n/a | `string` | `null` | no |
| source\_s3\_bucket | Bucket holding lambda source code. | `string` | `null` | no |
| source\_s3\_key | Key identifying location of code. | `string` | `null` | no |
| timeout | Execution timeout for the lambda. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |

<!-- END -->
