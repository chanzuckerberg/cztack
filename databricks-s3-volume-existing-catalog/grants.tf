locals {
  volume_r_grants = flatten([
    for bucket in var.volume_buckets : [
      for principal in bucket.volume_r_grant_principals : {
        bucket_name = bucket.bucket_name
        principal   = principal
      }
    ]
  ])

  volume_rw_grants = flatten([
    for bucket in var.volume_buckets : [
      for principal in bucket.volume_rw_grant_principals : {
        bucket_name = bucket.bucket_name
        principal   = principal
      }
    ]
  ])
}

# Read-only access grants
resource "databricks_grant" "volume_r" {
  for_each = { for idx, grant in local.volume_r_grants : "${grant.bucket_name}-${grant.principal}" => grant }

  volume     = databricks_volume.volume[each.value.bucket_name].id
  principal  = each.value.principal
  privileges = ["READ_VOLUME"]

  depends_on = [databricks_volume.volume]
}

# Read/write access grants
resource "databricks_grant" "volume_rw" {
  for_each = { for idx, grant in local.volume_rw_grants : "${grant.bucket_name}-${grant.principal}" => grant }

  volume     = databricks_volume.volume[each.value.bucket_name].id
  principal  = each.value.principal
  privileges = ["READ_VOLUME", "WRITE_VOLUME"]

  depends_on = [databricks_volume.volume]
}
