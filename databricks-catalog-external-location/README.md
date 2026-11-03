# databricks-catalog-external-location

Creates an S3 bucket, a Unity Catalog external location over it, and one or
more catalogs stored in it. Each catalog gets a group per privilege tier, and
the module manages the catalog's grants **authoritatively**: any catalog-level
grant not configured here is revoked on apply. Schema and Volume grants are not
managed, so bundles and other Terraform can add those.

## Privilege tiers

Tiers come from [`databricks-uc-privilege-tiers`](../databricks-uc-privilege-tiers).
For each catalog, `<code>_members` adds member IDs to the `<catalog>_<suffix>` group:

| Input | Group | Catalog privileges |
|-------|-------|--------------------|
| `usg_members` | `<catalog>_use` | `USE_CATALOG` |
| `r_members` | `<catalog>_read` | read tables and Volumes |
| `rw_members` | `<catalog>_write` | `r` plus write tables and Volumes, create tables, functions, Volumes and materialized views |
| `crt_members` | `<catalog>_create` | `USE_CATALOG`, `CREATE_SCHEMA` |
| `all_members` | `<catalog>_all` | `ALL_PRIVILEGES` |
| `mng_members` | `<catalog>_manage` | `ALL_PRIVILEGES`, `MANAGE` |

The `catalog_groups` output maps each catalog to its group names by code.

For needs the tiers don't cover:

- `extra_grants` grants catalog privileges to principals that already exist,
  such as a group you create in your own Terraform. `principal` is a name (group
  name, user email, or service principal application ID), not a member ID.
- `external_location_extra_grants` does the same on the external location.

## Example

Only the deploy service principal creates schemas (and owns them), only the
runtime service principal writes, and people read. In dev, everyone creates and
owns their own schema and can read everyone else's.

```hcl
catalogs = [
  {
    name        = "lobster_prod"
    owner       = var.deploy_sp_application_id
    r_members   = [var.lobster_people_group_id]
    rw_members  = [var.runtime_sp_id]
    crt_members = [var.deploy_sp_id]
  },
  {
    name        = "lobster_dev"
    owner       = var.deploy_sp_application_id
    r_members   = [var.workspace_users_group_id]
    crt_members = [var.workspace_users_group_id]
  },
]

external_location_extra_grants = [
  { principal = var.runtime_sp_application_id, privileges = ["CREATE_EXTERNAL_VOLUME"] },
]
```

External Volumes can't overlap a catalog's managed storage
(`s3://<bucket>/<catalog_prefix or name>`). Put them under a separate prefix of
the bucket, for example `s3://<bucket>/volumes/<catalog>/<volume>`.

## Upgrading to 0.3.0

Group names don't change, so existing groups and memberships are kept. Rename
the catalog attributes:

| Before | After |
|--------|-------|
| `all_privileges_members` | `all_members` |
| `manage_privileges_members` | `mng_members` |
| `read_privileges_members` | `r_members` |
| `write_privileges_members` | `rw_members` |
| `use_privileges_members` | `usg_members` |

The old names fail validation rather than being silently ignored.

Behavior changes to review in the first plan:

- `_write` no longer grants `CREATE_SCHEMA`. Add members who create schemas to `crt_members`.
- `_read` and `_write` now include Volume privileges, plus `EXECUTE` (and for
  `_write`, `REFRESH`, `APPLY_TAG`, `CREATE_FUNCTION`, `CREATE_VOLUME` and
  `CREATE_MATERIALIZED_VIEW`). They're inherited by every schema and Volume in
  the catalog, including Volumes whose access was previously limited.
- Each catalog gets a new `<catalog>_create` group.
- `catalog_groups` keys change from `all`, `manage`, `read`, `write`, `use` to
  `all`, `mng`, `r`, `rw`, `usg`, plus `crt`.

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >= 1.49.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_databricks.mws"></a> [databricks.mws](#provider\_databricks.mws) | >= 1.49.1 |
| <a name="provider_databricks.workspace"></a> [databricks.workspace](#provider\_databricks.workspace) | >= 1.49.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_catalog_bucket"></a> [catalog\_bucket](#module\_catalog\_bucket) | github.com/chanzuckerberg/cztack//aws-s3-private-bucket | v0.60.1 |
| <a name="module_tiers"></a> [tiers](#module\_tiers) | ../databricks-uc-privilege-tiers | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.databricks_external_location_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.databricks_external_location_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.databricks_external_location_access_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.databricks_external_location_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [databricks_catalog.catalog](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/catalog) | resource |
| [databricks_external_location.external_locations](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/external_location) | resource |
| [databricks_grants.databricks_credential_grants](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grants) | resource |
| [databricks_grants.databricks_external_location_grants](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grants) | resource |
| [databricks_grants.grants](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grants) | resource |
| [databricks_group.catalog_groups](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group_member.catalog_group_memberships](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_storage_credential.external](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/storage_credential) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.catalog_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.databricks_external_location_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.databricks_external_location_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_all_privileges_groups"></a> [all\_privileges\_groups](#input\_all\_privileges\_groups) | List of group names to grant access to | `list(string)` | n/a | yes |
| <a name="input_catalogs"></a> [catalogs](#input\_catalogs) | List of catalogs to create with their cooresponding attributes.<br/><br/>`<code>_members` (usg, r, rw, crt, all, mng) are member IDs added to the catalog's built-in tier groups.<br/>`extra_grants` grants privileges to existing principals by name, for example a group created by the caller.<br/>Catalog grants are authoritative: anything not listed here is revoked. | <pre>list(<br/>    object({<br/>      name                           = string<br/>      isolation_mode                 = optional(string, "ISOLATED")<br/>      enable_predictive_optimization = optional(string, "INHERIT")<br/>      owner                          = string<br/>      catalog_prefix                 = optional(string, "")<br/><br/>      usg_members = optional(list(string), [])<br/>      r_members   = optional(list(string), [])<br/>      rw_members  = optional(list(string), [])<br/>      crt_members = optional(list(string), [])<br/>      all_members = optional(list(string), [])<br/>      mng_members = optional(list(string), [])<br/><br/>      extra_grants = optional(list(object({<br/>        principal  = string<br/>        privileges = list(string)<br/>      })), [])<br/><br/>      # Renamed in 0.3.0. Kept only so the validation below can reject them;<br/>      # without them Terraform silently drops the old attributes and every<br/>      # membership is removed.<br/>      all_privileges_members    = optional(list(string))<br/>      manage_privileges_members = optional(list(string))<br/>      read_privileges_members   = optional(list(string))<br/>      write_privileges_members  = optional(list(string))<br/>      use_privileges_members    = optional(list(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_databricks_external_id"></a> [databricks\_external\_id](#input\_databricks\_external\_id) | ID of the databricks external location | `string` | n/a | yes |
| <a name="input_external_location_extra_grants"></a> [external\_location\_extra\_grants](#input\_external\_location\_extra\_grants) | (Optional) Grants on the external location for existing principals, in addition to `all_privileges_groups`.<br/>`principal` is a principal name (group name, user email, or service principal application ID), not a member ID.<br/>For example, grant a job's service principal CREATE\_EXTERNAL\_VOLUME to let it create external Volumes. | <pre>list(object({<br/>    principal  = string<br/>    privileges = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_external_location_name"></a> [external\_location\_name](#input\_external\_location\_name) | Name of the external location | `string` | n/a | yes |
| <a name="input_override_bucket_name_prefix"></a> [override\_bucket\_name\_prefix](#input\_override\_bucket\_name\_prefix) | Override prefix of newly-created S3 bucket as the storage root of the catalog.<br/>Defaults to ${project}-${env} (full name: ${project}-${env}-dbx-catalog-bucket). | `string` | `null` | no |
| <a name="input_override_role_name_infix"></a> [override\_role\_name\_infix](#input\_override\_role\_name\_infix) | Override infix of IAM role used for accessing newly-created bucket.<br/>Defaults to ${env} (full name: external\_location\_dbx\_${env}\_aws\_role) | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalog_groups"></a> [catalog\_groups](#output\_catalog\_groups) | Group names keyed by catalog name, then by tier code (usg, r, rw, crt, all, mng) |
| <a name="output_catalogs"></a> [catalogs](#output\_catalogs) | Map of created Databricks catalogs, keyed by catalog name |
| <a name="output_external_location"></a> [external\_location](#output\_external\_location) | The Databricks external location |
<!-- END -->
