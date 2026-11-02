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

mock_provider "databricks" {
  alias = "mws"
}

mock_provider "databricks" {
  alias = "workspace"
}

variables {
  tags = {
    project   = "lobster"
    env       = "prod"
    service   = "catalog"
    owner     = "test"
    managedBy = "terraform"
  }
  all_privileges_groups  = ["admins_group"]
  databricks_external_id = "external-id"
  external_location_name = "lobster-prod"
  catalogs = [
    {
      name        = "lobster_prod"
      owner       = "deploy-sp-app-id"
      r_members   = ["people-group-id"]
      rw_members  = ["runtime-sp-id"]
      crt_members = ["deploy-sp-id"]
    },
  ]
}

run "builtin_groups_keep_current_names" {
  command = plan

  assert {
    condition = toset(keys(databricks_group.catalog_groups)) == toset([
      "lobster_prod_use",
      "lobster_prod_read",
      "lobster_prod_write",
      "lobster_prod_create",
      "lobster_prod_all",
      "lobster_prod_manage",
    ])
    error_message = "Built-in groups must keep their current suffixes, plus _create"
  }
  assert {
    condition = output.catalog_groups["lobster_prod"] == {
      usg = "lobster_prod_use"
      r   = "lobster_prod_read"
      rw  = "lobster_prod_write"
      crt = "lobster_prod_create"
      all = "lobster_prod_all"
      mng = "lobster_prod_manage"
    }
    error_message = "catalog_groups must be keyed by tier code"
  }
  assert {
    condition = toset(keys(databricks_group_member.catalog_group_memberships)) == toset([
      "lobster_prod_read_people-group-id",
      "lobster_prod_write_runtime-sp-id",
      "lobster_prod_create_deploy-sp-id",
    ])
    error_message = "Membership keys must stay <group_name>_<member> so existing memberships aren't recreated"
  }
}

run "catalog_grants" {
  command = plan

  assert {
    condition = toset(one([
      for g in databricks_grants.grants["lobster_prod"].grant : g.privileges if g.principal == "lobster_prod_create"
    ])) == toset(["USE_CATALOG", "CREATE_SCHEMA"])
    error_message = "_create must grant only USE_CATALOG and CREATE_SCHEMA"
  }
  assert {
    condition = !contains(one([
      for g in databricks_grants.grants["lobster_prod"].grant : g.privileges if g.principal == "lobster_prod_write"
    ]), "CREATE_SCHEMA")
    error_message = "_write must not grant CREATE_SCHEMA"
  }
  assert {
    condition = contains(one([
      for g in databricks_grants.grants["lobster_prod"].grant : g.privileges if g.principal == "lobster_prod_read"
    ]), "READ_VOLUME")
    error_message = "_read must grant READ_VOLUME"
  }
}

run "extra_groups_and_grants" {
  command = plan

  variables {
    catalogs = [
      {
        name  = "lobster_prod"
        owner = "deploy-sp-app-id"
        extra_groups = {
          ingest = { privileges = ["USE_CATALOG", "USE_SCHEMA", "READ_VOLUME"], members = ["ingest-id"] }
        }
        extra_grants = [
          { principal = "account users", privileges = ["BROWSE"] },
        ]
      },
    ]
    external_location_extra_grants = [
      { principal = "runtime-sp-app-id", privileges = ["CREATE_EXTERNAL_VOLUME"] },
    ]
  }

  assert {
    condition     = contains(keys(databricks_group.catalog_groups), "lobster_prod_ingest")
    error_message = "extra_groups must create <catalog>_<key>"
  }
  assert {
    condition     = output.catalog_groups["lobster_prod"]["ingest"] == "lobster_prod_ingest"
    error_message = "catalog_groups must include extra groups by key"
  }
  assert {
    condition     = contains(keys(databricks_group_member.catalog_group_memberships), "lobster_prod_ingest_ingest-id")
    error_message = "extra_groups members must be added"
  }
  assert {
    condition = toset(one([
      for g in databricks_grants.grants["lobster_prod"].grant : g.privileges if g.principal == "lobster_prod_ingest"
    ])) == toset(["USE_CATALOG", "USE_SCHEMA", "READ_VOLUME"])
    error_message = "extra_groups privileges must be granted"
  }
  assert {
    condition     = length([for g in databricks_grants.grants["lobster_prod"].grant : g if g.principal == "account users"]) == 1
    error_message = "extra_grants must be merged into the catalog grants"
  }
  assert {
    condition = toset([for g in databricks_grants.databricks_external_location_grants[0].grant : g.principal]) == toset([
      "admins_group",
      "runtime-sp-app-id",
    ])
    error_message = "external_location_extra_grants must be merged with all_privileges_groups"
  }
}

run "external_location_grants_without_all_privileges_groups" {
  command = plan

  variables {
    all_privileges_groups = []
    external_location_extra_grants = [
      { principal = "runtime-sp-app-id", privileges = ["CREATE_EXTERNAL_VOLUME"] },
    ]
  }

  assert {
    condition     = length(databricks_grants.databricks_external_location_grants) == 1
    error_message = "External location grants must exist when only extra grants are set"
  }
}

run "rejects_renamed_attributes" {
  command = plan

  variables {
    catalogs = [
      {
        name                    = "lobster_prod"
        owner                   = "deploy-sp-app-id"
        read_privileges_members = ["people-group-id"]
      },
    ]
  }

  expect_failures = [var.catalogs]
}

run "rejects_reserved_extra_group_key" {
  command = plan

  variables {
    catalogs = [
      {
        name         = "lobster_prod"
        owner        = "deploy-sp-app-id"
        extra_groups = { rw = { privileges = ["SELECT"] } }
      },
    ]
  }

  expect_failures = [databricks_group.catalog_groups]
}

run "rejects_group_name_collision_across_catalogs" {
  command = plan

  variables {
    catalogs = [
      { name = "lobster_prod", owner = "deploy-sp-app-id" },
      {
        name         = "lobster"
        owner        = "deploy-sp-app-id"
        extra_groups = { prod_read = { privileges = ["SELECT"] } }
      },
    ]
  }

  expect_failures = [databricks_group.catalog_groups]
}

run "rejects_duplicate_grant_principal" {
  command = plan

  variables {
    catalogs = [
      {
        name  = "lobster_prod"
        owner = "deploy-sp-app-id"
        extra_grants = [
          { principal = "lobster_prod_read", privileges = ["MODIFY"] },
        ]
      },
    ]
  }

  expect_failures = [databricks_grants.grants]
}
