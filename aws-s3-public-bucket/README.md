<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.29.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.29.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.public_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.remove_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_public_list"></a> [allow\_public\_list](#input\_allow\_public\_list) | Allow public to list bucket contents. | `bool` | `false` | no |
| <a name="input_append_public_suffix"></a> [append\_public\_suffix](#input\_append\_public\_suffix) | Whether to append -public at the end of the bucket name. Only set this to false for buckets that live in designated AWS accounts, like for AWS Open Data. | `bool` | `true` | no |
| <a name="input_bucket_contents"></a> [bucket\_contents](#input\_bucket\_contents) | Describe the data within this bucket. | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket. Note that `-public` will be appended to `bucket_name`s that don't contain a `public` substring. This module will output the computed `bucket_name`. | `string` | n/a | yes |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | A policy to attach to this bucket. | `string` | `""` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Keep old versions of objects in this bucket. | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Allow objects to be deleted when the bucket is destroyed without errors. | `bool` | `false` | no |
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | Log bucket name and prefix to enable logs for this bucket | `object({ name = string, prefix = string })` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. | `string` | n/a | yes |
| <a name="input_public_read_justification"></a> [public\_read\_justification](#input\_public\_read\_justification) | Describe why this bucket must be public and what it is being used for. | `string` | n/a | yes |
| <a name="input_require_tls"></a> [require\_tls](#input\_require\_tls) | Require TLS to read objects from this bucket. | `bool` | `true` | no |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Public bucket ARN |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Domain where you host the public bucket |
| <a name="output_id"></a> [id](#output\_id) | Public Bucket ID |
| <a name="output_name"></a> [name](#output\_name) | Name of this public bucket. It should have `public` in its name |
<!-- END -->
