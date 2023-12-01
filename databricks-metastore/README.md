<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_databricks.workspace"></a> [databricks.workspace](#provider\_databricks.workspace) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.metastore_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.metastore_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.metastore_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_kms_alias.metastore_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.metastore_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.metastore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [databricks_catalog.sandbox](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/catalog) | resource |
| [databricks_grants.admin](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grants) | resource |
| [databricks_grants.poweruser](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grants) | resource |
| [databricks_metastore.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/metastore) | resource |
| [databricks_metastore_assignment.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/metastore_assignment) | resource |
| [databricks_metastore_data_access.metastore_data_access](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/metastore_data_access) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.metastore_assumerole_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.metastore_role_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_groups"></a> [admin\_groups](#input\_admin\_groups) | List of databricks groups to grant admin access for metastore; includes owner by default | `list(string)` | `[]` | no |
| <a name="input_databricks_external_id"></a> [databricks\_external\_id](#input\_databricks\_external\_id) | External ID for Databricks account | `string` | n/a | yes |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Deletion window in days for S3 encryption key | `number` | `7` | no |
| <a name="input_delta_sharing_recipient_token_lifetime_in_seconds"></a> [delta\_sharing\_recipient\_token\_lifetime\_in\_seconds](#input\_delta\_sharing\_recipient\_token\_lifetime\_in\_seconds) | Lifetime of delta sharing recipient token in seconds | `number` | `3600` | no |
| <a name="input_delta_sharing_scope"></a> [delta\_sharing\_scope](#input\_delta\_sharing\_scope) | Delta sharing scope | `string` | `"INTERNAL"` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Enable key rotation for S3 encryption key | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Force destroy metastore if data exists | `bool` | `false` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the metastore; should be a group display name | `string` | `"data-infra-admin"` | no |
| <a name="input_powerusers"></a> [powerusers](#input\_powerusers) | List of databricks groups to grant poweruser access for metastore | `list(string)` | <pre>[<br>  "powerusers"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Fogg generated tags for the environment | `object({ project : string, env : string, service : string, owner : string })` | n/a | yes |
| <a name="input_workspace_url"></a> [workspace\_url](#input\_workspace\_url) | URL of the workspace to use to create this metastore | `string` | n/a | yes |
| <a name="input_workspaces"></a> [workspaces](#input\_workspaces) | Map of workspace names to ids to associate with this metastore | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_metastore_id"></a> [metastore\_id](#output\_metastore\_id) | ID of the metastore |
<!-- END -->