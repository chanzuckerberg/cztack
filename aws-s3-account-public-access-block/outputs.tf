output block_settings {
  description = "The computed block configuration"
  value = {
    block_public_acls   = local.block_public_acls
    block_public_policy = local.block_public_policy

    # These affect existing buckets, policies, and acls
    ignore_public_acls      = local.ignore_public_acls
    restrict_public_buckets = local.restrict_public_buckets
  }
}
