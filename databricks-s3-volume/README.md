# databricks-s3-volume

Creates an external Unity Catalog Volume backed by S3, and optionally its
catalog and schema. Each level the module creates gets a group per privilege
tier from [`databricks-uc-privilege-tiers`](../databricks-uc-privilege-tiers):

| Level | Group name | Tiers | Grants |
|-------|------------|-------|--------|
| Catalog (`create_catalog = true`) | `<catalog>_<suffix>` | `usg`, `r`, `rw`, `crt`, `all`, `mng` | **authoritative**: catalog grants not configured here are revoked |
| Schema (`create_schema = true`) | `<catalog>_<schema>_<suffix>` | `usg`, `r`, `rw`, `all`, `mng` | additive |
| Volume | `<catalog>_<schema>_<volume>_<suffix>` | `r`, `rw`, `all`, `mng` | additive |

`<level>_<code>_members` (for example `catalog_rw_members`, `volume_r_members`)
are member IDs added to those groups. The owner is always added to the catalog
and schema `all` and `mng` groups. The `catalog_groups`, `schema_groups` and
`volume_groups` outputs map codes to group names.

For needs the tiers don't cover, each level has:

- `<level>_extra_groups`: more groups with your own privileges and member IDs.
  Keys can't be a tier code or suffix.
- `<level>_extra_grants`: grants to principals that already exist, by name
  (group name, user email, or service principal application ID). Repeated
  principals are merged.

## Upgrading to 0.4.0

Requires Terraform 1.7 or later. Group names don't change; the module moves
existing groups, memberships, and schema and Volume grants in state, so none
are recreated.

Rename the inputs:

| Before | After |
|--------|-------|
| `<level>_manage_grant_principals` | `<level>_mng_members` |
| `<level>_all_grant_principals` | `<level>_all_members` |
| `<level>_r_grant_principals` | `<level>_r_members` |
| `<level>_rw_grant_principals` | `<level>_rw_members` |
| `<level>_usage_grant_principals` | `<level>_usg_members` |

Behavior changes to review in the first plan:

- **Catalog grants become authoritative** when `create_catalog = true`. The five
  per-tier catalog grants are dropped from state without being revoked and
  replaced by one `databricks_grants`, which revokes any other catalog-level
  grant. Check current grants first with `databricks grants get catalog <name>`
  and add the ones to keep to `catalog_extra_grants`.
- Catalog `rw` no longer grants `CREATE_SCHEMA`; add those members to
  `catalog_crt_members`. A new `<catalog>_create` group is created.
- Catalog and schema `r` and `rw` gain Volume privileges, and `rw` gains
  `MODIFY` at schema level and `EXECUTE`, `REFRESH`, `APPLY_TAG`,
  `CREATE_FUNCTION`, `CREATE_VOLUME` and `CREATE_MATERIALIZED_VIEW` at catalog
  level. They're inherited by everything inside.
- `catalog_usg_members` and `schema_usg_members` are now actually added to the
  `_use` groups (previously the groups were always empty).
- The unused `<catalog>_<schema>_<volume>_use` group is deleted.

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >= 1.82.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_databricks.mws"></a> [databricks.mws](#provider\_databricks.mws) | >= 1.82.0 |
| <a name="provider_databricks.workspace"></a> [databricks.workspace](#provider\_databricks.workspace) | >= 1.82.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_databricks_bucket"></a> [databricks\_bucket](#module\_databricks\_bucket) | github.com/chanzuckerberg/cztack//aws-s3-private-bucket | v0.71.0 |
| <a name="module_tiers"></a> [tiers](#module\_tiers) | ../databricks-uc-privilege-tiers | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.dbx_unity_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.dbx_unity_aws_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.dbx_unity_aws_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [databricks_catalog.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/catalog) | resource |
| [databricks_external_location.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/external_location) | resource |
| [databricks_grant.schema](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.schema_extra](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.volume_extra](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grants.catalog](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grants) | resource |
| [databricks_group.catalog](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group.catalog_extra](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group.schema](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group.schema_extra](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group.volume_extra](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group_member.catalog_all](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.catalog_crt](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.catalog_extra](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.catalog_manage](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.catalog_r](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.catalog_rw](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.catalog_use](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.schema_all](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.schema_extra](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.schema_manage](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.schema_r](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.schema_rw](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.schema_use](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.volume_all](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.volume_extra](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
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
| <a name="input_catalog_all_members"></a> [catalog\_all\_members](#input\_catalog\_all\_members) | (Optional) Member IDs to add to the catalog's \_all group (ALL\_PRIVILEGES). Owner is included | `list(string)` | `[]` | no |
| <a name="input_catalog_bucket_name"></a> [catalog\_bucket\_name](#input\_catalog\_bucket\_name) | (Optional) Override storage root of catalog instead of using bucket name | `string` | `null` | no |
| <a name="input_catalog_crt_members"></a> [catalog\_crt\_members](#input\_catalog\_crt\_members) | (Optional) Member IDs to add to the catalog's \_create group (USE\_CATALOG, CREATE\_SCHEMA) | `list(string)` | `[]` | no |
| <a name="input_catalog_extra_grants"></a> [catalog\_extra\_grants](#input\_catalog\_extra\_grants) | (Optional) Catalog grants for existing principals, by name (group name, user email, or service principal application ID). Only used when create\_catalog is true; catalog grants are authoritative | <pre>list(object({<br/>    principal  = string<br/>    privileges = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_catalog_extra_groups"></a> [catalog\_extra\_groups](#input\_catalog\_extra\_groups) | (Optional) Additional `<catalog>_<key>` groups, with their catalog privileges and member IDs. Only used when create\_catalog is true. Keys can't be a tier code or suffix | <pre>map(object({<br/>    privileges = list(string)<br/>    members    = optional(list(string), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_catalog_mng_members"></a> [catalog\_mng\_members](#input\_catalog\_mng\_members) | (Optional) Member IDs to add to the catalog's \_manage group (ALL\_PRIVILEGES, MANAGE). Owner is included | `list(string)` | `[]` | no |
| <a name="input_catalog_name"></a> [catalog\_name](#input\_catalog\_name) | Name of the Databricks existing catalog to add the volume to | `string` | n/a | yes |
| <a name="input_catalog_r_members"></a> [catalog\_r\_members](#input\_catalog\_r\_members) | (Optional) Member IDs to add to the catalog's \_read group | `list(string)` | `[]` | no |
| <a name="input_catalog_rw_members"></a> [catalog\_rw\_members](#input\_catalog\_rw\_members) | (Optional) Member IDs to add to the catalog's \_write group | `list(string)` | `[]` | no |
| <a name="input_catalog_usg_members"></a> [catalog\_usg\_members](#input\_catalog\_usg\_members) | (Optional) Member IDs to add to the catalog's \_use group (USE\_CATALOG) | `list(string)` | `[]` | no |
| <a name="input_create_catalog"></a> [create\_catalog](#input\_create\_catalog) | Flag to create a new catalog or look for an existing one with the given name | `bool` | n/a | yes |
| <a name="input_create_catalog_bucket"></a> [create\_catalog\_bucket](#input\_create\_catalog\_bucket) | n/a | `bool` | `false` | no |
| <a name="input_create_catalog_storage_credentials"></a> [create\_catalog\_storage\_credentials](#input\_create\_catalog\_storage\_credentials) | (Optional) Flag to create a new Databricks storage credential for the catalog or look for an existing one for the given bucket\_name | `bool` | `true` | no |
| <a name="input_create_schema"></a> [create\_schema](#input\_create\_schema) | Flag to create a new catalog or look for an existing one with the given name | `bool` | n/a | yes |
| <a name="input_create_volume_bucket"></a> [create\_volume\_bucket](#input\_create\_volume\_bucket) | n/a | `bool` | `false` | no |
| <a name="input_create_volume_storage_credentials"></a> [create\_volume\_storage\_credentials](#input\_create\_volume\_storage\_credentials) | (Optional) Flag to create a new Databricks storage credential for the volume or look for an existing one for the given bucket\_name | `bool` | `true` | no |
| <a name="input_enable_file_events"></a> [enable\_file\_events](#input\_enable\_file\_events) | (Optional) Flag to enable file events on the external locations | `bool` | `false` | no |
| <a name="input_file_event_queue_url"></a> [file\_event\_queue\_url](#input\_file\_event\_queue\_url) | (Optional) URL of an existing SQS queue to use for file events on the external locations. If set (and enable\_file\_events is true), a user-provided SQS queue is used; otherwise a Databricks-managed SQS queue is created. | `string` | `null` | no |
| <a name="input_metastore_id"></a> [metastore\_id](#input\_metastore\_id) | ID of metastore to create catalog in | `string` | n/a | yes |
| <a name="input_override_policy_documents"></a> [override\_policy\_documents](#input\_override\_policy\_documents) | (Optional) Additional bucket policies to apply to the buckets. Mapped by bucket name. These should already be in JSON | `map(list(string))` | `{}` | no |
| <a name="input_override_unity_aws_role_name"></a> [override\_unity\_aws\_role\_name](#input\_override\_unity\_aws\_role\_name) | (Optional) Override the default Unity Catalog AWS IAM role name used when creating storage credentials | `string` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | User or group name of the owner - will be applied to the catalog, schema, and volume, if applicable | `string` | n/a | yes |
| <a name="input_owner_id"></a> [owner\_id](#input\_owner\_id) | User or group id of the owner - will be applied to the catalog, schema, and volume, if applicable | `string` | n/a | yes |
| <a name="input_read_only_volume"></a> [read\_only\_volume](#input\_read\_only\_volume) | (Optional) Flag to set volume as read-only | `bool` | `false` | no |
| <a name="input_schema_all_members"></a> [schema\_all\_members](#input\_schema\_all\_members) | (Optional) Member IDs to add to the schema's \_all group (ALL\_PRIVILEGES). Owner is included | `list(string)` | `[]` | no |
| <a name="input_schema_extra_grants"></a> [schema\_extra\_grants](#input\_schema\_extra\_grants) | (Optional) Schema grants for existing principals, by name (group name, user email, or service principal application ID). Only used when create\_schema is true | <pre>list(object({<br/>    principal  = string<br/>    privileges = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_schema_extra_groups"></a> [schema\_extra\_groups](#input\_schema\_extra\_groups) | (Optional) Additional `<catalog>_<schema>_<key>` groups, with their schema privileges and member IDs. Only used when create\_schema is true. Keys can't be a tier code or suffix | <pre>map(object({<br/>    privileges = list(string)<br/>    members    = optional(list(string), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_schema_mng_members"></a> [schema\_mng\_members](#input\_schema\_mng\_members) | (Optional) Member IDs to add to the schema's \_manage group (ALL\_PRIVILEGES, MANAGE). Owner is included | `list(string)` | `[]` | no |
| <a name="input_schema_name"></a> [schema\_name](#input\_schema\_name) | Name of the Databricks schema to add the volume to | `string` | n/a | yes |
| <a name="input_schema_r_members"></a> [schema\_r\_members](#input\_schema\_r\_members) | (Optional) Member IDs to add to the schema's \_read group | `list(string)` | `[]` | no |
| <a name="input_schema_rw_members"></a> [schema\_rw\_members](#input\_schema\_rw\_members) | (Optional) Member IDs to add to the schema's \_write group | `list(string)` | `[]` | no |
| <a name="input_schema_usg_members"></a> [schema\_usg\_members](#input\_schema\_usg\_members) | (Optional) Member IDs to add to the schema's \_use group (USE\_SCHEMA) | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | REQUIRED: Tags to include for this environment. | <pre>object({<br/>    project : string<br/>    env : string<br/>    service : string<br/>    owner : string<br/>    managedBy : string<br/>  })</pre> | n/a | yes |
| <a name="input_volume_all_members"></a> [volume\_all\_members](#input\_volume\_all\_members) | (Optional) Member IDs to add to the volume's \_all group (ALL\_PRIVILEGES) | `list(string)` | `[]` | no |
| <a name="input_volume_bucket_name"></a> [volume\_bucket\_name](#input\_volume\_bucket\_name) | (Optional) Name of S3 bucket to use for Databricks volume. NOTE: if provided, you will need to update the bucket policy whereever it is defined to allow Databricks access | `string` | `null` | no |
| <a name="input_volume_comment"></a> [volume\_comment](#input\_volume\_comment) | (Optional) Comment to add to the Databricks volume | `string` | `"Managed by Terraform - this is a default volume for the Databricks workspace"` | no |
| <a name="input_volume_extra_grants"></a> [volume\_extra\_grants](#input\_volume\_extra\_grants) | (Optional) Volume grants for existing principals, by name (group name, user email, or service principal application ID) | <pre>list(object({<br/>    principal  = string<br/>    privileges = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_volume_extra_groups"></a> [volume\_extra\_groups](#input\_volume\_extra\_groups) | (Optional) Additional `<catalog>_<schema>_<volume>_<key>` groups, with their volume privileges and member IDs. Keys can't be a tier code or suffix | <pre>map(object({<br/>    privileges = list(string)<br/>    members    = optional(list(string), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_volume_mng_members"></a> [volume\_mng\_members](#input\_volume\_mng\_members) | (Optional) Member IDs to add to the volume's \_manage group (ALL\_PRIVILEGES, MANAGE) | `list(string)` | `[]` | no |
| <a name="input_volume_name"></a> [volume\_name](#input\_volume\_name) | Name of the Databricks volume to create | `string` | n/a | yes |
| <a name="input_volume_r_members"></a> [volume\_r\_members](#input\_volume\_r\_members) | (Optional) Member IDs to add to the volume's \_read group (READ\_VOLUME) | `list(string)` | `[]` | no |
| <a name="input_volume_rw_members"></a> [volume\_rw\_members](#input\_volume\_rw\_members) | (Optional) Member IDs to add to the volume's \_write group (READ\_VOLUME, WRITE\_VOLUME) | `list(string)` | `[]` | no |
| <a name="input_volume_schema_properties"></a> [volume\_schema\_properties](#input\_volume\_schema\_properties) | Properties of the Databricks schema to add the volume to | `map(string)` | `{}` | no |
| <a name="input_volume_storage_location"></a> [volume\_storage\_location](#input\_volume\_storage\_location) | (Optional) Prefix to use for the storage location in case of an existing bucket (e.g. 's3://bucket' or 's3://bucket/prefix') | `string` | `null` | no |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | Name of the Databricks catalog to add the volume to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalog_groups"></a> [catalog\_groups](#output\_catalog\_groups) | Catalog group names keyed by tier code or catalog\_extra\_groups key. Empty unless create\_catalog is true |
| <a name="output_catalog_name"></a> [catalog\_name](#output\_catalog\_name) | n/a |
| <a name="output_dbx_unity_aws_role_arns"></a> [dbx\_unity\_aws\_role\_arns](#output\_dbx\_unity\_aws\_role\_arns) | n/a |
| <a name="output_schema_groups"></a> [schema\_groups](#output\_schema\_groups) | Schema group names keyed by tier code or schema\_extra\_groups key. Empty unless create\_schema is true |
| <a name="output_schema_name"></a> [schema\_name](#output\_schema\_name) | n/a |
| <a name="output_volume_bucket_name"></a> [volume\_bucket\_name](#output\_volume\_bucket\_name) | n/a |
| <a name="output_volume_groups"></a> [volume\_groups](#output\_volume\_groups) | Volume group names keyed by tier code or volume\_extra\_groups key |
| <a name="output_volume_name"></a> [volume\_name](#output\_volume\_name) | n/a |
| <a name="output_volume_path"></a> [volume\_path](#output\_volume\_path) | n/a |
<!-- END -->