resource "databricks_grant" "volume_r" {
  for_each = {
    for bucket in var.volume_buckets : "${bucket.bucket_name}_${bucket.volume_r_grant_principals}" => bucket
    if length(bucket.volume_r_grant_principals) > 0
  }
  volume    = each.value.bucket_name
  principal = each.value.volume_r_grant_principals[count.index]
  privileges = ["READ_VOLUME"]
}

resource "databricks_grant" "volume_rw" {
  for_each = {
    for bucket in var.volume_buckets : "${bucket.bucket_name}_${bucket.volume_rw_grant_principals}" => bucket
    if length(bucket.volume_rw_grant_principals) > 0
  }
  volume    = each.value.bucket_name
  principal = each.value.volume_rw_grant_principals[count.index]
  privileges = ["READ_VOLUME", "WRITE_VOLUME"]
}
