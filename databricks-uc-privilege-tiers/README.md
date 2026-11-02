# databricks-uc-privilege-tiers

Single source of truth for the Unity Catalog privilege tiers used by
`databricks-catalog-external-location` and `databricks-s3-volume`. It creates no
resources; those modules read it with `source = "../databricks-uc-privilege-tiers"`.

Each tier has a short code, used in module inputs (`r_members`, `catalog_rw_members`)
and outputs, and a group suffix, used in group names (`<catalog>_read`).

| Code | Group suffix | Catalog | Schema | Volume |
|------|--------------|---------|--------|--------|
| `usg` | `_use` | `USE_CATALOG` | `USE_SCHEMA` | — |
| `r` | `_read` | `USE_CATALOG`, `BROWSE`, `USE_SCHEMA`, `SELECT`, `EXECUTE`, `READ_VOLUME` | `USE_SCHEMA`, `SELECT`, `EXECUTE`, `READ_VOLUME` | `READ_VOLUME` |
| `rw` | `_write` | `r` plus `MODIFY`, `REFRESH`, `APPLY_TAG`, `CREATE_TABLE`, `CREATE_FUNCTION`, `CREATE_VOLUME`, `CREATE_MATERIALIZED_VIEW`, `WRITE_VOLUME` | same additions over schema `r` | `READ_VOLUME`, `WRITE_VOLUME` |
| `crt` | `_create` | `USE_CATALOG`, `CREATE_SCHEMA` | — | — |
| `all` | `_all` | `ALL_PRIVILEGES` | `ALL_PRIVILEGES` | `ALL_PRIVILEGES` |
| `mng` | `_manage` | `ALL_PRIVILEGES`, `MANAGE` | `ALL_PRIVILEGES`, `MANAGE` | `ALL_PRIVILEGES`, `MANAGE` |

Privileges granted on a catalog or schema are inherited by everything inside it,
including Volume privileges.

## Changing tiers

Release-please only releases a module when a commit touches its directory. A
commit that changes this module must also update the consuming modules (at
least their READMEs) so they're released with the change.

Changing a `suffix` renames every existing group of that tier, which deletes
and recreates the groups in consumers. Don't.

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_levels"></a> [levels](#output\_levels) | Short codes of the tiers that exist at each level, keyed by level. |
| <a name="output_reserved_names"></a> [reserved\_names](#output\_reserved\_names) | All tier codes and group suffixes. Custom group keys must not use these. |
| <a name="output_tiers"></a> [tiers](#output\_tiers) | Privilege tiers keyed by short code. Each tier has a group name `suffix` and a privilege list per level (`catalog`, `schema`, `volume`); null means the tier doesn't exist at that level. |
<!-- END -->
