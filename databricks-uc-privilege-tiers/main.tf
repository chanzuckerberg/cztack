locals {
  read_base = ["USE_SCHEMA", "SELECT", "EXECUTE", "READ_VOLUME"]
  write_extra = [
    "MODIFY",
    "REFRESH",
    "APPLY_TAG",
    "CREATE_TABLE",
    "CREATE_FUNCTION",
    "CREATE_VOLUME",
    "CREATE_MATERIALIZED_VIEW",
    "WRITE_VOLUME",
  ]
  catalog_base = ["USE_CATALOG", "BROWSE"]

  # Keys are the short codes used in module inputs and outputs. `suffix` is the
  # group name suffix; changing one renames (and recreates) existing groups.
  # A null privilege list means the tier doesn't exist at that level.
  tiers = {
    usg = {
      suffix  = "use"
      catalog = ["USE_CATALOG"]
      schema  = ["USE_SCHEMA"]
      volume  = null
    }
    r = {
      suffix  = "read"
      catalog = concat(local.catalog_base, local.read_base)
      schema  = local.read_base
      volume  = ["READ_VOLUME"]
    }
    rw = {
      suffix  = "write"
      catalog = concat(local.catalog_base, local.read_base, local.write_extra)
      schema  = concat(local.read_base, local.write_extra)
      volume  = ["READ_VOLUME", "WRITE_VOLUME"]
    }
    crt = {
      suffix  = "create"
      catalog = ["USE_CATALOG", "CREATE_SCHEMA"]
      schema  = null
      volume  = null
    }
    all = {
      suffix  = "all"
      catalog = ["ALL_PRIVILEGES"]
      schema  = ["ALL_PRIVILEGES"]
      volume  = ["ALL_PRIVILEGES"]
    }
    mng = {
      suffix  = "manage"
      catalog = ["ALL_PRIVILEGES", "MANAGE"]
      schema  = ["ALL_PRIVILEGES", "MANAGE"]
      volume  = ["ALL_PRIVILEGES", "MANAGE"]
    }
  }

  levels = {
    for level in ["catalog", "schema", "volume"] : level => [
      for code, tier in local.tiers : code if tier[level] != null
    ]
  }

  reserved_names = distinct(concat(keys(local.tiers), [for tier in local.tiers : tier.suffix]))
}
