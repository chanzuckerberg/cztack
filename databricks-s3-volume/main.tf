# Volume bucket (UC supported)

// https://docs.databricks.com/administration-guide/multiworkspace/iam-role.html#language-Your%C2%A0VPC,%C2%A0custom
locals {
  iam_role_path          = "/databricks/"
  databricks_aws_account = "414351767826" # Databricks' own AWS account, not CZI's. See https://docs.databricks.com/en/administration-guide/account-settings-e2/credentials.html#step-1-create-a-cross-account-iam-role

  # catalog and schema use underscores
  # bucket names use hyphens

  catalog_name = var.create_catalog ? replace(var.catalog_name, "-", "_") : var.catalog_name
  schema_name  = var.create_schema ? replace(var.schema_name, "-", "_") : var.schema_name
  volume_name  = replace(var.volume_name, "-", "_")

  # shorten if >64 chars
  _unity_aws_role_name = replace("${local.catalog_name}-${local.schema_name}-${local.volume_name}-dbx", "_", "")
  _vowel_list          = ["y", "u", "i", "o", "a", "e"]
  _unity_aws_candidate_role_names = [
    for j in range(1, length(local._vowel_list) + 1) :
    replace(local._unity_aws_role_name, "/[${join("", slice(local._vowel_list, 0, j))}]/", "")
  ]
  # [ for j in range(1, length(["y", "u", "i", "o", "a", "e"]) + 1) : replace("<string>", "/[${join("", slice(["y", "u", "i", "o", "a", "e"], 0, j))}]/", "") ]
  unity_aws_role_name = element([for i, s in local._unity_aws_candidate_role_names : s if 0 <= length(s) && length(s) <= 64], 0)

  _catalog_bucket_name = coalesce(var.catalog_bucket_name, local.catalog_name)
  catalog_bucket_name  = local._catalog_bucket_name != null ? replace(local._catalog_bucket_name, "_", "-") : null
  volume_bucket_name = (
    var.create_volume_bucket == true
    ? replace(var.volume_bucket_name, "_", "-")
    # if bucket created externally, it already shouldn't have any `_`
    : coalesce(var.volume_bucket_name, local.catalog_bucket_name)
  )

  dbx_resource_storage_config = {
    "VOLUME" : {
      resource_name   = local.volume_name,
      create_resource = true

      create_bucket = var.create_volume_bucket,
      bucket_name   = local.volume_bucket_name,

      create_storage_credential = var.create_volume_storage_credentials,
      storage_location = coalesce(
        var.volume_storage_location,
        "s3://${local.volume_bucket_name}/${local.schema_name}/${local.volume_name}"
      ),
      storage_credential_name = "${local.catalog_name}-${local.schema_name}-${local.volume_name}-volume",
    },
    "CATALOG" : {
      resource_name   = var.create_catalog == true ? local.catalog_name : local.catalog_bucket_name,
      create_resource = var.create_catalog

      bucket_name   = local.catalog_bucket_name,
      create_bucket = var.create_catalog_bucket

      create_storage_credential = var.create_catalog || var.create_catalog_storage_credentials,
      storage_location          = "s3://${local.catalog_bucket_name}",
      storage_credential_name   = "${local.catalog_name}-catalog",
    }
  }

  # project into lists per

  resource_access_config = [
    for storage_type, config in local.dbx_resource_storage_config : {
      for config_key in config :
      config_key => config
      if contains(["resource_name", "bucket_name", "storage_location", "storage_credential_name"], config_key)
          && config.create_storage_credential == true
    }
  ]

  resource_s3_buckets = toset(compact([
    var.create_volume_bucket ? local.dbx_resource_storage_config["VOLUME"]["bucket_name"] : null,
    var.create_catalog_bucket ? local.dbx_resource_storage_config["CATALOG"]["bucket_name"] : null,
  ]))
}

### Databricks storage credential - allows workspace to access an external location.
### NOTE: names need to be unique across an account, not just a workspace
### NOTE:

resource "databricks_storage_credential" "this" {
  for_each = toset([for _, config in local.dbx_resource_storage_config : config["storage_credential_name"]])

  depends_on = [
    resource.aws_iam_role.dbx_unity_aws_role,
    resource.aws_iam_role_policy_attachment.dbx_unity_aws_access,
    module.databricks_bucket
  ]

  name = each.key

  aws_iam_role {
    role_arn = aws_iam_role.dbx_unity_aws_role[0].arn
  }

  comment   = "Managed by Terraform - access for ${each.key}"
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
    resource.aws_iam_role.dbx_unity_aws_role,
    databricks_storage_credential.this,
  ]

  name            = databricks_storage_credential.this[each.value.storage_credential_name].name
  url             = each.value.storage_location
  credential_name = databricks_storage_credential.this[each.value.storage_credential_name].name
  comment         = "Managed by Terraform - access for ${each.value.storage_credential_name}"
  read_only       = var.read_only_volume
}

# New catalog, schema, and volume

resource "databricks_catalog" "volume" {
  for_each   = toset([
    for resource_type, resource_config in local.dbx_resource_storage_config :
    resource_config["resource_name"]
    if resource_type == "CATALOG" && resource_config.create_resource == true
  ])
  depends_on = [databricks_external_location.this]

  name         = each.key
  metastore_id = var.metastore_id
  owner        = var.owner
  storage_root = "s3://${each.value}"
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
  depends_on       = [databricks_external_location.this, databricks_schema.volume]
  name             = local.volume_name
  catalog_name     = local.catalog_name
  schema_name      = local.schema_name
  volume_type      = "EXTERNAL"
  storage_location = local.dbx_resource_storage_config["VOLUME"]["storage_location"]
  owner            = var.owner
  comment          = "This volume is managed by Terraform - ${var.volume_comment}"
}
