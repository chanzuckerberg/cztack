data "aws_iam_policy_document" "databricks-s3" {
  statement {
    sid    = "grant databricks access"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.databricks_aws_account}:root"]
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::${local.name}/*",
      "arn:aws:s3:::${local.name}",
    ]
  }
}

module "databricks_bucket" {
  source           = "github.com/chanzuckerberg/cztack//aws-s3-private-bucket?ref=v0.60.1"
  bucket_name      = local.name
  bucket_policy    = data.aws_iam_policy_document.databricks-s3.json
  project          = var.project
  env              = var.env
  service          = var.service
  owner            = var.owner
  object_ownership = var.object_ownership
}
