locals {
  enable_s3 = "${var.enable_s3 ? 1 : 0}"

}
// Readonly everywhere
resource "aws_iam_role_policy_attachment" "s3-readonly" {
  role       = "${aws_iam_role.poweruser.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}


// Write confined to regions
data "aws_iam_policy_document" "s3-write-regional" {
  statement {
    sid       = "s3WriteRegional"
    actions   = ["s3:*"]
    resources = ["*"]
    // HACK: I wish I could conditionally assign this block but don't know how to do it in terraform
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["${var.authorized_regions}"]
    }
  }
}

resource "aws_iam_role_policy" "s3-write-regional" {
  count  = "${local.enable_s3 * local.all_regions_disabled}"
  name   = "s3-write-regional"
  policy = "${data.aws_iam_policy_document.s3-write-regional.json}"
}

resource "aws_iam_role_policy_attachment" "s3-write-all-regions" {
  count      = "${local.enable_s3 * local.all_regions_enabled}"
  role       = "${aws_iam_role.poweruser.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
