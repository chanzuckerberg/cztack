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

resource "databricks_grants" "volume" {
  for_each = toset([bucket.volume_name for bucket in var.volume_buckets])

  volume = each.value

  # Read-only access grants
  dynamic "grant" {
    for_each = each.value.volume_r_grant_principals
    content {
      principal = grant.value
      privileges = ["READ_VOLUME"]
    }
  }

  # Read/write access grants
  dynamic "grant" {
    for_each = each.value.volume_rw_grant_principals
    content {
      principal = grant.value
      privileges = ["READ_VOLUME", "WRITE_VOLUME"]
    }
  }
}