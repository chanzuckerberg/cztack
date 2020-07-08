locals {
  # Define the grant ACL for the Cloudfront logging S3 bucket,
  # In order for the awslogsdelivery account to write log files to the bucket,
  # we need to grant the AWS log delivery group the FULL_CONTROL access to the logging bucket
  # LP's AWS account also has the FULL_CONTROL access to the bucket, this is specified by the canonical user id
  # More details in https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html#ChangeSettings
  grants = [
    {
      canonical_user_id : data.aws_canonical_user_id.current_user.id
      permissions : ["FULL_CONTROL"]

    },
    {
      canonical_user_id : "c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0" # AWS log delivery group's canonical user id
      permissions : ["FULL_CONTROL"]

    }
  ]
}

data "aws_canonical_user_id" "current_user" {}

module "aws-cloudfront-logs-bucket" {
  source                                 = "../aws-s3-private-bucket"
  grants                                 = local.grants
  env                                    = var.env
  owner                                  = var.owner
  project                                = var.project
  service                                = var.service
  bucket_name                            = var.bucket_name
  domain_name                            = aws_s3_bucket.bucket.bucket_domain_name
  bucket_arn                             = aws_s3_bucket.bucket.arn
  bucket_id                              = aws_s3_bucket.bucket.id
  bucket_policy                          = var.bucket_policy
  enable_versioning                      = var.enable_versioning
  abort_incomplete_multipart_upload_days = var.abort_incomplete_multipart_upload_days
  public_access_block                    = var.public_access_block
  lifecycle_rules                        = var.lifecycle_rules
}
