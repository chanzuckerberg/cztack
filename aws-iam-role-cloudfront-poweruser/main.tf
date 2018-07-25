resource "aws_iam_role" "role" {
  name = "${var.role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${var.source_account}:root"
    },
    "Action": "sts:AssumeRole"
  }
}
EOF
}

data "aws_iam_policy_document" "s3" {
  statement {
    sid = "s3"

    actions = [
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_prefix}*",
      "arn:aws:s3:::${var.s3_bucket_prefix}*/*",
    ]
  }
}

data "aws_iam_policy_document" "cloudfront" {
  statement {
    sid       = "cloudfront"
    actions   = ["cloudfront:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "s3" {
  name        = "${var.role_name}-s3"
  description = "Provide access to s3 resources for a distribution ${var.role_name}"
  policy      = "${data.aws_iam_policy_document.s3.json}"
}

resource "aws_iam_policy" "cloudfront" {
  name        = "${var.role_name}-cloudfront"
  description = "Provide access to cloudfront ${var.role_name}"
  policy      = "${data.aws_iam_policy_document.cloudfront.json}"
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.s3.arn}"
}

resource "aws_iam_role_policy_attachment" "cloudfront" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.cloudfront.arn}"
}
