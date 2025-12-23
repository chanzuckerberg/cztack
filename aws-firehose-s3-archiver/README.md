This is a module that ingests cloudwatch logs and sends them to the bucket using AWS Data Firehose. There's some things you need to keep in mind as you work on this:

1. The resources here should be in the same region as your cloudwatch log group.
2. Consider the s3_prefix variable carefully. Any team members unfamiliar with the s3 bucket should be able to navigate it to debug any issues.

Before you use this module:
1. Make sure the cloudwatch log group and s3 bucket already exist
2. Make sure the s3 bucket policy already allows this account to write to the bucket
3. Make sure the bucket "owns" the files: https://repost.aws/knowledge-center/s3-change-object-ownership 
<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_subscription_filter.cloudwatch_subscription_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) | resource |
| [aws_iam_role.firehose_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sender_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.kinesis_perms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kinesis_firehose_delivery_stream.s3_archiver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.firehose_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.firehose_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sender_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sender_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the bucket that will hold the logs. | `string` | n/a | yes |
| <a name="input_cloudwatch_filter_pattern"></a> [cloudwatch\_filter\_pattern](#input\_cloudwatch\_filter\_pattern) | A cloudwatch filter expression to identify which cloudwatch log events get ingested into s3 | `string` | n/a | yes |
| <a name="input_enable_backup"></a> [enable\_backup](#input\_enable\_backup) | Whether you want to enable the collection of backup files in a raw/ folder. | `bool` | `false` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | The log group you're pulling events from. Should be from the same reason. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Common name (identifier) to assign to all of the IAM resources in this module. | `string` | n/a | yes |
| <a name="input_s3_prefix"></a> [s3\_prefix](#input\_s3\_prefix) | Folder prefix to assign to separate these files from other files in the bucket. Make sure you have a slash `/` at the end | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END -->