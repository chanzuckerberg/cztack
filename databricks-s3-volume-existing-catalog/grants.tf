# volume
resource "databricks_grant" "volume_r" {
  for_each   = toset(var.volume_r_grant_principals)
  volume     = databricks_volume.volume.id
  principal  = each.value
  privileges = ["READ_VOLUME"]
}

resource "databricks_grant" "volume_rw" {
  for_each   = toset(var.volume_rw_grant_principals)
  volume     = databricks_volume.volume.id
  principal  = each.value
  privileges = ["READ_VOLUME", "WRITE_VOLUME"]
}