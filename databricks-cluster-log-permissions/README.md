# README
<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_aws.czi-logs"></a> [aws.czi-logs](#provider\_aws.czi-logs) | n/a |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.cluster_log_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cluster_log_cluster_rw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.cluster_log_bucket_read_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cluster_log_bucket_write_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cluster_log_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cluster_log_rw_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.additional_write_access_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.read_access_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.write_access_attachment_default_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.write_access_attachment_rw_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_grant.additional_bucket_kms_encryption_key_grant](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_grant) | resource |
| [aws_kms_grant.bucket_kms_encryption_key_grant_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_grant) | resource |
| [aws_kms_grant.bucket_kms_encryption_key_grant_rw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_grant) | resource |
| [databricks_instance_profile.cluster_log_cluster](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/instance_profile) | resource |
| [databricks_instance_profile.cluster_log_cluster_rw](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/instance_profile) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_for_cluster_log_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_log_bucket_read_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_log_bucket_write_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_reader"></a> [add\_reader](#input\_add\_reader) | Flag to add reader role for logs - should only be invoked for the ie workspace | `bool` | `false` | no |
| <a name="input_bucket_kms_encryption_key_arn"></a> [bucket\_kms\_encryption\_key\_arn](#input\_bucket\_kms\_encryption\_key\_arn) | ARN for KMS key used to encrypt bucket for cluster logs | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment name | `string` | n/a | yes |
| <a name="input_existing_role_names"></a> [existing\_role\_names](#input\_existing\_role\_names) | List of other existing instance policy roles on the workspace for which to add cluster log write permissions | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_logging_role_arn"></a> [default\_logging\_role\_arn](#output\_default\_logging\_role\_arn) | ARN of the AWS IAM role created for default logs access |
| <a name="output_rw_logging_role_arn"></a> [rw\_logging\_role\_arn](#output\_rw\_logging\_role\_arn) | ARN of the AWS IAM role created for read and write logs access |
| <a name="output_rw_logging_role_instance_profile_arn"></a> [rw\_logging\_role\_instance\_profile\_arn](#output\_rw\_logging\_role\_instance\_profile\_arn) | ARN of the AWS instance profile created for read and write logs access |
<!-- END -->