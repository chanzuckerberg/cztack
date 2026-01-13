<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_databricks.mws"></a> [databricks.mws](#provider\_databricks.mws) | n/a |
| <a name="provider_databricks.workspace"></a> [databricks.workspace](#provider\_databricks.workspace) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

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
| [databricks_external_location.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/external_location) | resource |
| [databricks_grant.catalog_all](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.catalog_manage](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.catalog_read](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.catalog_use](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.catalog_write](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.schema_all](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.schema_manage](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.schema_r](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.schema_rw](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.schema_use](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.volume_all](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.volume_manage](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.volume_r](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.volume_rw](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_group.catalog](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group.schema](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group_member.catalog_all](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.catalog_manage](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.catalog_r](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.catalog_rw](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.schema_all](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.schema_manage](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.schema_r](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.schema_rw](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.volume_all](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.volume_manage](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.volume_r](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.volume_rw](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_schema.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/schema) | resource |
| [databricks_storage_credential.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/storage_credential) | resource |
| [databricks_volume.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/volume) | resource |
| [time_sleep.wait_30_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.databricks-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dbx_unity_aws_role_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.volume_bucket_dbx_unity_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_rw_bucket_grant_arns"></a> [additional\_rw\_bucket\_grant\_arns](#input\_additional\_rw\_bucket\_grant\_arns) | (Optional) Additional AWS ARNs to grant read/write permissions to on the bucket (may be necessary for service principals, instance profiles, or users | `list(string)` | `[]` | no |
| <a name="input_bucket_object_ownership"></a> [bucket\_object\_ownership](#input\_bucket\_object\_ownership) | Set default owner of all objects within bucket (e.g., bucket vs. object owner) | `string` | `null` | no |
| <a name="input_catalog_all_grant_principals"></a> [catalog\_all\_grant\_principals](#input\_catalog\_all\_grant\_principals) | (Optional) Databricks groups to grant all-privileges permission to on the catalog. Owner is included | `list(string)` | `[]` | no |
| <a name="input_catalog_bucket_name"></a> [catalog\_bucket\_name](#input\_catalog\_bucket\_name) | (Optional) Override storage root of catalog instead of using bucket name | `string` | `null` | no |
| <a name="input_catalog_manage_grant_principals"></a> [catalog\_manage\_grant\_principals](#input\_catalog\_manage\_grant\_principals) | (Optional) Databricks groups to grant MANAGE permission to on the catalog. | `list(string)` | `[]` | no |
| <a name="input_catalog_name"></a> [catalog\_name](#input\_catalog\_name) | Name of the Databricks existing catalog to add the volume to | `string` | n/a | yes |
| <a name="input_catalog_r_grant_principals"></a> [catalog\_r\_grant\_principals](#input\_catalog\_r\_grant\_principals) | (Optional) Databricks groups to grant read-only permissions to on the catalog | `list(string)` | `[]` | no |
| <a name="input_catalog_rw_grant_principals"></a> [catalog\_rw\_grant\_principals](#input\_catalog\_rw\_grant\_principals) | (Optional) Databricks groups to grant read/write permissions to on the catalog | `list(string)` | `[]` | no |
| <a name="input_catalog_usage_grant_principals"></a> [catalog\_usage\_grant\_principals](#input\_catalog\_usage\_grant\_principals) | (Optional) Databricks groups to grant usage permission to on the catalog | `list(string)` | `[]` | no |
| <a name="input_create_catalog"></a> [create\_catalog](#input\_create\_catalog) | Flag to create a new catalog or look for an existing one with the given name | `bool` | n/a | yes |
| <a name="input_create_catalog_bucket"></a> [create\_catalog\_bucket](#input\_create\_catalog\_bucket) | n/a | `bool` | `false` | no |
| <a name="input_create_catalog_storage_credentials"></a> [create\_catalog\_storage\_credentials](#input\_create\_catalog\_storage\_credentials) | (Optional) Flag to create a new Databricks storage credential for the catalog or look for an existing one for the given bucket\_name | `bool` | `true` | no |
| <a name="input_create_schema"></a> [create\_schema](#input\_create\_schema) | Flag to create a new catalog or look for an existing one with the given name | `bool` | n/a | yes |
| <a name="input_create_volume_bucket"></a> [create\_volume\_bucket](#input\_create\_volume\_bucket) | n/a | `bool` | `false` | no |
| <a name="input_create_volume_storage_credentials"></a> [create\_volume\_storage\_credentials](#input\_create\_volume\_storage\_credentials) | (Optional) Flag to create a new Databricks storage credential for the volume or look for an existing one for the given bucket\_name | `bool` | `true` | no |
| <a name="input_metastore_id"></a> [metastore\_id](#input\_metastore\_id) | ID of metastore to create catalog in | `string` | n/a | yes |
| <a name="input_override_policy_documents"></a> [override\_policy\_documents](#input\_override\_policy\_documents) | (Optional) Additional bucket policies to apply to the buckets. Mapped by bucket name. These should already be in JSON | `map(list(string))` | `{}` | no |
| <a name="input_override_unity_aws_role_name"></a> [override\_unity\_aws\_role\_name](#input\_override\_unity\_aws\_role\_name) | (Optional) Override the default Unity Catalog AWS IAM role name used when creating storage credentials | `string` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | User or group name of the owner - will be applied to the catalog, schema, and volume, if applicable | `string` | n/a | yes |
| <a name="input_owner_id"></a> [owner\_id](#input\_owner\_id) | User or group id of the owner - will be applied to the catalog, schema, and volume, if applicable | `string` | n/a | yes |
| <a name="input_read_only_volume"></a> [read\_only\_volume](#input\_read\_only\_volume) | (Optional) Flag to set volume as read-only | `bool` | `false` | no |
| <a name="input_schema_all_grant_principals"></a> [schema\_all\_grant\_principals](#input\_schema\_all\_grant\_principals) | (Optional) Databricks groups to grant all-privileges permission to on the schema. Owner is included | `list(string)` | `[]` | no |
| <a name="input_schema_manage_grant_principals"></a> [schema\_manage\_grant\_principals](#input\_schema\_manage\_grant\_principals) | (Optional) Databricks groups to grant MANAGE permission to on the schema. Owner is included | `list(string)` | `[]` | no |
| <a name="input_schema_name"></a> [schema\_name](#input\_schema\_name) | Name of the Databricks schema to add the volume to | `string` | n/a | yes |
| <a name="input_schema_r_grant_principals"></a> [schema\_r\_grant\_principals](#input\_schema\_r\_grant\_principals) | (Optional) Databricks groups to grant read-only permissions to on the schema | `list(string)` | `[]` | no |
| <a name="input_schema_rw_grant_principals"></a> [schema\_rw\_grant\_principals](#input\_schema\_rw\_grant\_principals) | (Optional) Databricks groups to grant read/write permissions to on the schema | `list(string)` | `[]` | no |
| <a name="input_schema_usage_grant_principals"></a> [schema\_usage\_grant\_principals](#input\_schema\_usage\_grant\_principals) | (Optional) Databricks groups to grant usage permission to on the schema | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | REQUIRED: Tags to include for this environment. | <pre>object({<br>    project : string<br>    env : string<br>    service : string<br>    owner : string<br>    managedBy : string<br>  })</pre> | n/a | yes |
| <a name="input_volume_all_grant_principals"></a> [volume\_all\_grant\_principals](#input\_volume\_all\_grant\_principals) | (Optional) Databricks groups to grant all-privileges permission to on the volume. Owner is included | `list(string)` | `[]` | no |
| <a name="input_volume_bucket_name"></a> [volume\_bucket\_name](#input\_volume\_bucket\_name) | (Optional) Name of S3 bucket to use for Databricks volume. NOTE: if provided, you will need to update the bucket policy whereever it is defined to allow Databricks access | `string` | `null` | no |
| <a name="input_volume_comment"></a> [volume\_comment](#input\_volume\_comment) | (Optional) Comment to add to the Databricks volume | `string` | `"Managed by Terraform - this is a default volume for the Databricks workspace"` | no |
| <a name="input_volume_manage_grant_principals"></a> [volume\_manage\_grant\_principals](#input\_volume\_manage\_grant\_principals) | (Optional) Databricks groups to grant MANAGE permission to on the volume. Owner is included | `list(string)` | `[]` | no |
| <a name="input_volume_name"></a> [volume\_name](#input\_volume\_name) | Name of the Databricks volume to create | `string` | n/a | yes |
| <a name="input_volume_r_grant_principals"></a> [volume\_r\_grant\_principals](#input\_volume\_r\_grant\_principals) | (Optional) Databricks groups to grant read-only permissions to on the volume | `list(string)` | `[]` | no |
| <a name="input_volume_rw_grant_principals"></a> [volume\_rw\_grant\_principals](#input\_volume\_rw\_grant\_principals) | (Optional) Databricks groups to grant read/write permissions to on the volume | `list(string)` | `[]` | no |
| <a name="input_volume_schema_properties"></a> [volume\_schema\_properties](#input\_volume\_schema\_properties) | Properties of the Databricks schema to add the volume to | `map(string)` | `{}` | no |
| <a name="input_volume_storage_location"></a> [volume\_storage\_location](#input\_volume\_storage\_location) | (Optional) Prefix to use for the storage location in case of an existing bucket (e.g. 's3://bucket' or 's3://bucket/prefix') | `string` | `null` | no |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | Name of the Databricks catalog to add the volume to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalog_name"></a> [catalog\_name](#output\_catalog\_name) | n/a |
| <a name="output_dbx_unity_aws_role_arns"></a> [dbx\_unity\_aws\_role\_arns](#output\_dbx\_unity\_aws\_role\_arns) | n/a |
| <a name="output_schema_name"></a> [schema\_name](#output\_schema\_name) | n/a |
| <a name="output_volume_bucket_name"></a> [volume\_bucket\_name](#output\_volume\_bucket\_name) | n/a |
| <a name="output_volume_name"></a> [volume\_name](#output\_volume\_name) | n/a |
| <a name="output_volume_path"></a> [volume\_path](#output\_volume\_path) | n/a |
<!-- END -->