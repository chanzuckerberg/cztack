locals {
  is_all  = var.restrict == "all"
  is_none = var.restrict == "none"



  # These only affect new acls and policies by rejecting requests that contain them
  block_public_acls   = ! local.is_none # all or new
  block_public_policy = ! local.is_none # all or new

  # These affect existing buckets, policies, and acls
  ignore_public_acls      = local.is_all
  restrict_public_buckets = local.is_all

}


# See https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PublicAccessBlockConfiguration.html for more info
resource "aws_s3_account_public_access_block" "block" {
  # These only affect new acls and policies by rejecting requests that contain them
  block_public_acls   = local.block_public_acls
  block_public_policy = local.block_public_policy

  # These affect existing buckets, policies, and acls
  ignore_public_acls      = local.ignore_public_acls
  restrict_public_buckets = local.restrict_public_buckets
}
