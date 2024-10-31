locals {
  tags = {
    env     = var.env
    owner   = var.owner
    service = var.service
    project = var.project
  }
}

module "assume_role_policy" {
  source             = "../aws-assume-role-policy"
  source_account_ids = var.source_account_ids
  saml_idp_arns      = var.saml_idp_arns
  oidc               = var.oidc
  env                = var.env
  owner              = var.owner
  service            = var.service
  project            = var.project
}

resource "aws_iam_role" "role" {
  name               = var.role_name
  assume_role_policy = module.assume_role_policy.json
  tags               = local.tags
}

data "aws_iam_policy_document" "s3-bucket-readonly" {
  statement {
    sid    = "GetFiles"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersion"
    ]
    resources = formatlist("arn:aws:s3:::%s*/*", var.s3_bucket_names)
  }
  statement {
    sid    = "ListBucket"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads"
    ]
    resources = formatlist("arn:aws:s3:::%s*/*", var.s3_bucket_names)
  }
  statement {
    sid    = "ShowAllowedBuckets"
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets"
    ]
    resources = toset(formatlist("arn:aws:s3:::%s", var.s3_bucket_names), formatlist("arn:aws:s3:::%s/*", var.s3_bucket_names))
  }
}

resource "aws_iam_policy" "s3" {
  name        = "${var.role_name}-s3"
  description = "Provide access to s3 resources for a distribution ${var.role_name}"
  policy      = data.aws_iam_policy_document.s3-bucket-readonly.json
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.s3.arn
}
