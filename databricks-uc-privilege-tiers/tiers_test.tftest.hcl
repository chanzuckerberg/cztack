run "levels" {
  command = plan

  assert {
    condition     = output.levels.catalog == ["all", "crt", "mng", "r", "rw", "usg"]
    error_message = "Unexpected catalog-level tiers"
  }
  assert {
    condition     = output.levels.schema == ["all", "mng", "r", "rw", "usg"]
    error_message = "Unexpected schema-level tiers"
  }
  assert {
    condition     = output.levels.volume == ["all", "mng", "r", "rw"]
    error_message = "Unexpected volume-level tiers"
  }
}

run "privileges" {
  command = plan

  assert {
    condition     = !contains(output.tiers.rw.catalog, "CREATE_SCHEMA")
    error_message = "Catalog rw must not include CREATE_SCHEMA; that's the crt tier"
  }
  assert {
    condition     = alltrue([for p in ["CREATE_VOLUME", "READ_VOLUME", "WRITE_VOLUME", "MODIFY"] : contains(output.tiers.rw.catalog, p)])
    error_message = "Catalog rw is missing write or Volume privileges"
  }
  assert {
    condition     = contains(output.tiers.r.catalog, "READ_VOLUME") && !contains(output.tiers.r.catalog, "MODIFY")
    error_message = "Catalog r must read Volumes and must not write"
  }
  assert {
    condition     = output.tiers.crt.catalog == ["USE_CATALOG", "CREATE_SCHEMA"]
    error_message = "crt must grant only USE_CATALOG and CREATE_SCHEMA"
  }
}

run "reserved_names" {
  command = plan

  assert {
    condition     = alltrue([for n in ["usg", "use", "r", "read", "rw", "write", "crt", "create", "all", "mng", "manage"] : contains(output.reserved_names, n)])
    error_message = "reserved_names must include every code and suffix"
  }
}
