<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_databricks_bucket"></a> [databricks\_bucket](#module\_databricks\_bucket) | github.com/chanzuckerberg/cztack//aws-s3-private-bucket | v0.71.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.dbx_unity_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.dbx_unity_aws_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.dbx_unity_aws_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [databricks_catalog.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/catalog) | resource |
| [databricks_external_location.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/external_location) | resource |
| [databricks_schema.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/schema) | resource |
| [databricks_storage_credential.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/storage_credential) | resource |
| [databricks_volume.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/volume) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.databricks-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dbx_unity_aws_role_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.volume_bucket_dbx_unity_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_object_ownership"></a> [bucket\_object\_ownership](#input\_bucket\_object\_ownership) | Set default owner of all objects within bucket (e.g., bucket vs. object owner) | `string` | `null` | no |
| <a name="input_catalog_name"></a> [catalog\_name](#input\_catalog\_name) | Name of the Databricks existing catalog to add the volume to | `string` | n/a | yes |
| <a name="input_catalog_owner"></a> [catalog\_owner](#input\_catalog\_owner) | User or group name of the catalog owner | `string` | n/a | yes |
| <a name="input_metastore_id"></a> [metastore\_id](#input\_metastore\_id) | ID of metastore to create catalog in | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | REQUIRED: Tags to include for this environment. | <pre>object({<br>    project : string<br>    env : string<br>    service : string<br>    owner : string<br>    managedBy : string<br>  })</pre> | n/a | yes |
| <a name="input_volume_bucket"></a> [volume\_bucket](#input\_volume\_bucket) | (Optional) Name of an existing S3 bucket to use for Databricks volume. NOTE: if provided, you will need to update the bucket policy whereever it is defined to allow Databricks access | `string` | `null` | no |
| <a name="input_volume_comment"></a> [volume\_comment](#input\_volume\_comment) | (Optional) Comment to add to the Databricks volume | `string` | `"Managed by Terraform - this is a default volume for the Databricks workspace"` | no |
| <a name="input_volume_name"></a> [volume\_name](#input\_volume\_name) | Name of the Databricks volume to create | `string` | n/a | yes |
| <a name="input_volume_schema_properties"></a> [volume\_schema\_properties](#input\_volume\_schema\_properties) | Properties of the Databricks schema to add the volume to | `map(string)` | `{}` | no |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | Name of the Databricks catalog to add the volume to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dbx_unity_aws_role_arn"></a> [dbx\_unity\_aws\_role\_arn](#output\_dbx\_unity\_aws\_role\_arn) | n/a |
| <a name="output_volume_specific_bucket_name"></a> [volume\_specific\_bucket\_name](#output\_volume\_specific\_bucket\_name) | n/a |
<!-- END -->