locals {
  volume_r_grants = flatten([
    for volume in var.volume_buckets : [
      for principal in volume.volume_r_grant_principals : {
        volume_name = volume.volume_name
        principal   = principal
      }
    ]
  ])

  volume_rw_grants = flatten([
    for volume in var.volume_buckets : [
      for principal in volume.volume_rw_grant_principals : {
        volume_name = volume.volume_name
        principal   = principal
      }
    ]
  ])
}

# Read-only access grants
resource "databricks_grant" "volume_r" {
  for_each = {
    for grant in local.volume_r_grants :
    "${grant.volume_name}+${grant.principal}" => grant
  }

  volume     = databricks_volume.volume[each.value.volume_name].id
  principal  = each.value.principal
  privileges = ["READ_VOLUME"]

  depends_on = [databricks_volume.volume]
}

# Read/write access grants
resource "databricks_grant" "volume_rw" {
  for_each = {
    for grant in local.volume_rw_grants :
    "${grant.volume_name}+${grant.principal}" => grant
  }

  volume     = databricks_volume.volume[each.value.volume_name].id
  principal  = each.value.principal
  privileges = ["READ_VOLUME", "WRITE_VOLUME"]

  depends_on = [databricks_volume.volume]
}
