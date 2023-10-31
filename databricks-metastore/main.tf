locals {
  name          = "${var.tags.project}-${var.tags.env}-${var.tags.service}"
  admins        = toset(concat(var.admin_groups, [var.owner]))
  workspace_ids = values(var.workspaces)
}

resource "databricks_metastore" "this" {
  provider                                          = databricks.workspace
  name                                              = "${local.name}-metastore"
  storage_root                                      = "s3://${aws_s3_bucket.metastore.id}/metastore"
  owner                                             = var.owner
  delta_sharing_scope                               = var.delta_sharing_scope
  delta_sharing_recipient_token_lifetime_in_seconds = var.delta_sharing_recipient_token_lifetime_in_seconds
  force_destroy                                     = var.force_destroy
}

resource "databricks_metastore_assignment" "this" {
  provider     = databricks.workspace
  for_each     = toset(local.workspace_ids)
  metastore_id = databricks_metastore.this.id
  workspace_id = each.value
}

resource "databricks_grants" "admin" {
  for_each  = local.admins
  provider  = databricks.workspace
  metastore = databricks_metastore.this.id
  grant {
    principal  = each.value
    privileges = ["CREATE_CATALOG", "CREATE_EXTERNAL_LOCATION", "CREATE_SHARE", "CREATE_RECIPIENT", "CREATE_PROVIDER"]
  }
}

resource "databricks_grants" "poweruser" {
  for_each  = toset(var.powerusers)
  provider  = databricks.workspace
  metastore = databricks_metastore.this.id
  grant {
    principal  = each.value
    privileges = ["CREATE_CATALOG", "CREATE_SHARE"]
  }
}

resource "databricks_metastore_data_access" "metastore_data_access" {
  provider     = databricks.workspace
  depends_on   = [databricks_metastore.this]
  metastore_id = databricks_metastore.this.id
  name         = aws_iam_role.metastore_access.name
  aws_iam_role { role_arn = aws_iam_role.metastore_access.arn }
  is_default = true
}

resource "databricks_catalog" "sandbox" {
  provider     = databricks.workspace
  metastore_id = databricks_metastore.this.id
  name         = "sandbox"
  comment      = "this catalog is managed by terraform"
  properties = {
    purpose = "testing"
  }
}