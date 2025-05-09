resource "databricks_grants" "volume" {
  for_each = toset([for bucket in var.volume_buckets : bucket.volume_name => bucket])

  volume = each.value

  # Read-only access grants
  dynamic "grant" {
    for_each = toset(each.value.volume_r_grant_principals)
    content {
      principal = grant.value
      privileges = ["READ_VOLUME"]
    }
  }

  # Read/write access grants
  dynamic "grant" {
    for_each = toset(each.value.volume_rw_grant_principals)
    content {
      principal = grant.value
      privileges = ["READ_VOLUME", "WRITE_VOLUME"]
    }
  }
}