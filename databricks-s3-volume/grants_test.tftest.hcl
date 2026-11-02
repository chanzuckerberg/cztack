mock_provider "aws" {
  mock_data "aws_iam_policy_document" {
    defaults = {
      json = "{}"
    }
  }
  mock_data "aws_caller_identity" {
    defaults = {
      account_id = "123456789012"
    }
  }
}

mock_provider "time" {}

mock_provider "databricks" {
  alias = "mws"
}

mock_provider "databricks" {
  alias = "workspace"
}

variables {
  workspace_name       = "test"
  metastore_id         = "metastore-id"
  owner                = "owner-group"
  owner_id             = "owner-id"
  create_catalog       = true
  catalog_name         = "cat"
  create_schema        = true
  schema_name          = "sch"
  volume_name          = "vol"
  create_volume_bucket = true
  tags = {
    project   = "test"
    env       = "test"
    service   = "test"
    owner     = "test"
    managedBy = "terraform"
  }
  catalog_r_members   = ["reader-id"]
  catalog_usg_members = ["user-id"]
  catalog_crt_members = ["deployer-id"]
  schema_usg_members  = ["user-id"]
  volume_r_members    = ["reader-id"]
}

run "groups_keep_current_names" {
  command = plan

  assert {
    condition = output.catalog_groups == {
      usg = "cat_use"
      r   = "cat_read"
      rw  = "cat_write"
      crt = "cat_create"
      all = "cat_all"
      mng = "cat_manage"
    }
    error_message = "Catalog groups must keep their current names, plus _create"
  }
  assert {
    condition = output.schema_groups == {
      usg = "cat_sch_use"
      r   = "cat_sch_read"
      rw  = "cat_sch_write"
      all = "cat_sch_all"
      mng = "cat_sch_manage"
    }
    error_message = "Schema groups must keep their current names"
  }
  assert {
    condition = output.volume_groups == {
      r   = "cat_sch_vol_read"
      rw  = "cat_sch_vol_write"
      all = "cat_sch_vol_all"
      mng = "cat_sch_vol_manage"
    }
    error_message = "Volume groups must keep their current names, without _use"
  }
}

run "use_and_create_groups_get_members" {
  command = plan

  assert {
    condition     = keys(databricks_group_member.catalog_use) == ["user-id"]
    error_message = "catalog_usg_members must be added to the catalog _use group"
  }
  assert {
    condition     = keys(databricks_group_member.schema_use) == ["user-id"]
    error_message = "schema_usg_members must be added to the schema _use group"
  }
  assert {
    condition     = keys(databricks_group_member.catalog_crt) == ["deployer-id"]
    error_message = "catalog_crt_members must be added to the catalog _create group"
  }
  assert {
    condition     = contains(keys(databricks_group_member.catalog_manage), "owner-id")
    error_message = "The owner must still be added to the catalog _manage group"
  }
}

run "catalog_grants_are_authoritative" {
  command = plan

  variables {
    catalog_extra_grants = [{ principal = "account users", privileges = ["BROWSE"] }]
    catalog_extra_groups = { ingest = { privileges = ["USE_CATALOG"], members = ["ingest-id"] } }
  }

  assert {
    condition = toset([for g in databricks_grants.catalog[0].grant : g.principal]) == toset([
      "cat_use", "cat_read", "cat_write", "cat_create", "cat_all", "cat_manage", "cat_ingest", "account users",
    ])
    error_message = "Catalog grants must cover every tier, extra group and extra grant"
  }
  assert {
    condition = toset(one([
      for g in databricks_grants.catalog[0].grant : g.privileges if g.principal == "cat_create"
    ])) == toset(["USE_CATALOG", "CREATE_SCHEMA"])
    error_message = "_create must grant only USE_CATALOG and CREATE_SCHEMA"
  }
  assert {
    condition     = keys(databricks_group_member.catalog_extra) == ["ingest/ingest-id"]
    error_message = "catalog_extra_groups members must be added"
  }
}

run "schema_and_volume_grants" {
  command = plan

  variables {
    schema_extra_grants = [
      { principal = "runtime-sp-app-id", privileges = ["USE_SCHEMA"] },
      { principal = "runtime-sp-app-id", privileges = ["SELECT"] },
    ]
    volume_extra_grants = [{ principal = "runtime-sp-app-id", privileges = ["READ_VOLUME", "WRITE_VOLUME"] }]
  }

  assert {
    condition     = contains(databricks_grant.schema["rw"].privileges, "MODIFY") && contains(databricks_grant.schema["rw"].privileges, "WRITE_VOLUME")
    error_message = "Schema rw must include MODIFY and WRITE_VOLUME"
  }
  assert {
    condition     = contains(databricks_grant.schema["r"].privileges, "READ_VOLUME")
    error_message = "Schema r must include READ_VOLUME"
  }
  assert {
    condition     = toset(databricks_grant.schema_extra["runtime-sp-app-id"].privileges) == toset(["USE_SCHEMA", "SELECT"])
    error_message = "Repeated schema_extra_grants principals must be merged"
  }
  assert {
    condition     = toset(databricks_grant.volume_extra["runtime-sp-app-id"].privileges) == toset(["READ_VOLUME", "WRITE_VOLUME"])
    error_message = "volume_extra_grants must be granted on the volume"
  }
  assert {
    condition     = toset(keys(databricks_grant.volume)) == toset(["r", "rw", "all", "mng"])
    error_message = "Volume grants must exist for each volume tier"
  }
}

run "existing_catalog_and_schema" {
  command = plan

  variables {
    create_catalog       = false
    create_schema        = false
    catalog_extra_grants = [{ principal = "account users", privileges = ["BROWSE"] }]
  }

  assert {
    condition     = length(databricks_grants.catalog) == 0 && length(databricks_group.catalog) == 0
    error_message = "No catalog groups or grants when the catalog already exists"
  }
  assert {
    condition     = length(databricks_grant.schema) == 0 && length(databricks_group.schema) == 0
    error_message = "No schema groups or grants when the schema already exists"
  }
  assert {
    condition     = length(databricks_group_member.catalog_use) == 0 && length(databricks_group_member.catalog_manage) == 0
    error_message = "No catalog memberships when the catalog already exists"
  }
  assert {
    condition     = length(databricks_grant.volume) == 4
    error_message = "Volume grants must still be created"
  }
}

run "rejects_reserved_extra_group_key" {
  command = plan

  variables {
    volume_extra_groups = { read = { privileges = ["READ_VOLUME"] } }
  }

  expect_failures = [databricks_group.volume_extra]
}

run "rejects_extra_grant_to_builtin_group" {
  command = plan

  variables {
    volume_extra_grants = [{ principal = "cat_sch_vol_read", privileges = ["WRITE_VOLUME"] }]
  }

  expect_failures = [databricks_grant.volume_extra]
}
