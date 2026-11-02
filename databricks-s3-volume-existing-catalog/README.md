# databricks-s3-volume-existing-catalog

> **Obsolete.** Use [`databricks-s3-volume`](../databricks-s3-volume) with
> `create_catalog = false` and `create_schema = false` instead. This module
> receives no new features.

Creates external Volumes over existing S3 buckets in an existing catalog and
schema, with one shared IAM role and storage credential, an external location
per bucket, and `READ_VOLUME` / `WRITE_VOLUME` grants to principals by name.

## Migrating to databricks-s3-volume

Call `databricks-s3-volume` once per Volume, reusing the external locations
this module created:

```hcl
module "volume" {
  source   = "github.com/chanzuckerberg/cztack//databricks-s3-volume?ref=databricks-s3-volume-v0.4.0"
  for_each = { for b in local.volume_buckets : b.volume_name => b }

  create_catalog = false
  create_schema  = false
  catalog_name   = var.catalog_name
  schema_name    = var.schema_name
  volume_name    = each.key

  volume_bucket_name                 = each.value.bucket_name
  volume_storage_location            = "s3://${each.value.bucket_name}${each.value.bucket_prefix != "" ? "/${each.value.bucket_prefix}" : ""}"
  create_volume_bucket               = false
  create_volume_storage_credentials  = false
  create_catalog_storage_credentials = false

  volume_extra_grants = concat(
    [for p in each.value.volume_r_grant_principals : { principal = p, privileges = ["READ_VOLUME"] }],
    [for p in each.value.volume_rw_grant_principals : { principal = p, privileges = ["READ_VOLUME", "WRITE_VOLUME"] }],
  )

  # owner, owner_id, metastore_id, workspace_name, tags, providers ...
}
```

Then, in the same root module and the same apply:

```hcl
# Keep each Volume instead of recreating it (one block per Volume).
moved {
  from = module.old.databricks_volume.volume["<volume>"]
  to   = module.volume["<volume>"].databricks_volume.volume
}

# Forget the rest of the old module without destroying it. The grants are
# re-added by volume_extra_grants; the storage credential, external locations
# and IAM role keep backing the Volumes. Import them elsewhere to keep managing
# them in Terraform.
removed {
  from = module.old
  lifecycle {
    destroy = false
  }
}
```

Check the plan before applying:

- Each Volume should be moved, not replaced. `databricks-s3-volume` replaces
  hyphens in `volume_name` with underscores, so a hyphenated name would be
  recreated; keep those on this module.
- The new module also creates empty `<catalog>_<schema>_<volume>_<tier>` groups.

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
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.volume_dbx_unity_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.volume_dbx_unity_aws_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.volume_dbx_unity_aws_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [databricks_external_location.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/external_location) | resource |
| [databricks_grant.volume_r](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_grant.volume_rw](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grant) | resource |
| [databricks_storage_credential.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/storage_credential) | resource |
| [databricks_volume.volume](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/volume) | resource |
| [time_sleep.wait_30_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.volume_bucket_dbx_unity_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.volume_dbx_unity_aws_role_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_catalog_name"></a> [catalog\_name](#input\_catalog\_name) | Name of the Databricks existing catalog to add the volume to | `string` | n/a | yes |
| <a name="input_catalog_owner"></a> [catalog\_owner](#input\_catalog\_owner) | User or group name of the catalog owner | `string` | n/a | yes |
| <a name="input_schema_name"></a> [schema\_name](#input\_schema\_name) | Name of the Databricks schema to add the volume to | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | REQUIRED: Tags to include for this environment. | <pre>object({<br/>    project : string<br/>    env : string<br/>    service : string<br/>    owner : string<br/>    managedBy : string<br/>  })</pre> | n/a | yes |
| <a name="input_volume_buckets"></a> [volume\_buckets](#input\_volume\_buckets) | List of external buckets and their corresponding groups that should have r/rw access to it | <pre>list(object({<br/>    volume_name : string<br/>    bucket_name : string<br/>    bucket_prefix : optional(string, "")<br/>    volume_r_grant_principals : optional(list(string), [])<br/>    volume_rw_grant_principals : optional(list(string), [])<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END -->
