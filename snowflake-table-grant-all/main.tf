locals {
  // https://docs.snowflake.com/en/user-guide/security-access-control-privileges.html#table-privileges
  privileges = [
    "SELECT",
    "INSERT",
    "UPDATE",
    "TRUNCATE",
    "DELETE",
    "REFERENCES",
  ]
}

resource snowflake_table_grant all {
  for_each = toset(local.privileges)

  database_name = var.database_name
  schema_name   = var.schema_name
  table_name    = var.table_name

  // HACK(el): The way the provider works, we can only have one grant per (db, share, table, on_future, with_grant_option) grant
  //           because of this, if we simulate an ALL grant for a tuple X for role foo through this module
  //           we couldn't then issue a SELECT grant for the same tuple X for a different role bar.
  //           We therefore expand this module so that you can issue specific privilege grants to other roles and shares
  //           It is a bit of a hack but probably can't do much better with the current structure of the provider (and its limitations).
  roles = setunion(
    var.roles,
    lookup(var.per_privilege_grants, each.value, { roles = [], shares = [] }).roles,
  )
  shares = setunion(
    var.shares,
    lookup(var.per_privilege_grants, each.value, { roles = [], shares = [] }).shares,
  )

  on_future         = var.on_future
  with_grant_option = var.with_grant_option

  privilege = each.value
}
