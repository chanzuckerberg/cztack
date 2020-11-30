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
  schema_name = var.schema_name
  table_name = var.table_name

  roles = var.roles
  shares = var.shares

  on_future = var.on_future
  with_grant_option = var.with_grant_option


  privilege = each.value
}
