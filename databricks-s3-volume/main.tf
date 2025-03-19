# Volume bucket (UC supported)

// https://docs.databricks.com/administration-guide/multiworkspace/iam-role.html#language-Your%C2%A0VPC,%C2%A0custom
locals {
  unity_aws_role_name    = "${var.catalog_name}-unity"
  iam_role_path          = "/databricks/"
  databricks_aws_account = "414351767826" # Databricks' own AWS account, not CZI's. See https://docs.databricks.com/en/administration-guide/account-settings-e2/credentials.html#step-1-create-a-cross-account-iam-role

  # catalog and schema use underscores
  # bucket names use hyphens

  catalog_name = var.create_catalog ? replace(var.catalog_name, "-", "_") : var.catalog_name
  schema_name  = var.create_schema ? replace(var.schema_name, "-", "_") : var.schema_name
  volume_name  = replace(var.volume_name, "-", "_")

  volume_bucket_name = var.create_volume_bucket ? replace(var.volume_bucket_name, "_", "-") : var.volume_bucket_name
  catalog_bucket_name = coalesce(
    replace(var.catalog_bucket_name, "_", "-"),
    local.catalog_name
  )

  create_storage_credentials = var.create_catalog || var.create_storage_credentials
  volume_storage_location = coalesce(
    var.volume_storage_location,
    "s3://${local.volume_bucket_name}/${local.schema_name}/${local.volume_name}"
  )

  dbx_resource_storage_config = toset([
    {
      bucket_name = local.volume_bucket_name,
      resource_name = local.volume_name,
      storage_location = local.volume_storage_location,
      storage_credential_name = "${local.catalog_name}-${local.schema_name}-${local.volume_name}-volume",
    },
    {
      bucket_name = local.catalog_bucket_name,
      resource_name = local.catalog_name,
      storage_location = local.catalog_bucket_name,
      storage_credential_name = "${local.catalog_name}-catalog",
    }
  ])
}

### Databricks storage credential - allows workspace to access an external location.
### NOTE: names need to be unique across an account, not just a workspace
### NOTE:

resource "databricks_storage_credential" "this" {
  for_each = (
    local.create_storage_credentials == true ?
    local.dbx_resource_storage_config :
    []
  )

  depends_on = [
    resource.aws_iam_role.dbx_unity_aws_role,
    resource.aws_iam_role_policy_attachment.dbx_unity_aws_access,
    module.databricks_bucket
  ]

  name = each.value.storage_credential_name

  aws_iam_role {
    role_arn = aws_iam_role.dbx_unity_aws_role[each.value.bucket_name].arn
  }

  comment   = "Managed by Terraform - access for ${each.value.bucket_name}"
  read_only = var.read_only_volume
}

# upstream external location sometimes takes a moment to register
resource "time_sleep" "wait_30_seconds" {
  depends_on = [databricks_storage_credential.this]

  create_duration = "30s"
}

resource "databricks_external_location" "this" {
  for_each = local.dbx_resource_storage_config
  depends_on = [
    time_sleep.wait_30_seconds,
    databricks_storage_credential.this,
  ]

  name            = databricks_storage_credential.this[each.value.bucket_name].name
  url             = "s3://${each.value.store_location}"
  credential_name = databricks_storage_credential.this[each.value.bucket_name].name
  comment         = "Managed by Terraform - access for ${each.value.bucket_name}"
  read_only       = var.read_only_volume
}

# New catalog, schema, and volume

resource "databricks_catalog" "volume" {
  for_each = (
    var.create_catalog ?
    [
      for element in local.dbx_resource_storage_config :
      element if element.resource_name == local.catalog_name
    ] :
    []
  )
  depends_on   = [databricks_external_location.this]

  name         = each.value.resource_name
  metastore_id = var.metastore_id
  owner        = var.owner
  storage_root = "s3://${each.value.catalog_bucket_name}"
  comment      = "this catalog is managed by terraform - default volume catalog for Databricks workspace ${var.workspace_name}"
  properties = {
    purpose = "this catalog is managed by terraform - default volume catalog for Databricks workspace ${var.workspace_name}"
  }
  isolation_mode = "ISOLATED"
}

resource "databricks_schema" "volume" {
  count = var.create_schema ? 1 : 0

  depends_on   = [databricks_catalog.volume]
  catalog_name = local.catalog_name
  name         = local.schema_name
  comment      = "This schema is managed by Terraform - ${var.volume_comment}"
  owner        = var.owner
  properties   = var.volume_schema_properties
}

resource "databricks_volume" "volume" {
  depends_on       = [databricks_external_location.volume, databricks_schema.volume]
  name             = local.volume_name
  catalog_name     = local.catalog_name
  schema_name      = local.schema_name
  volume_type      = "EXTERNAL"
  storage_location = local.volume_storage_location
  owner            = var.owner
  comment          = "This volume is managed by Terraform - ${var.volume_comment}"
}
