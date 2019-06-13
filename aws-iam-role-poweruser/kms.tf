
locals {
  enable_kms = "${var.enable_kms ? 1 : 0}"

// Write confined to regions
data "aws_iam_policy_document" "kms-write-regional" {
  statement {
    sid       = "kmsWriteRegional"
    actions   = ["kms:*"]
    resources = ["*"]
    // HACK: I wish I could conditionally assign this block but don't know how to do it in terraform
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["${var.authorized_regions}"]
    }
  }
}

data "aws_iam_policy_document" "kms-write" {
  statement {
    sid       = "kmsWrite"
    actions   = ["kms:*"]
    resources = ["*"]
  }
}
resource "aws_iam_role_policy" "kms-write-regional" {
  count  = "${local.enable_kms * local.all_regions_disabled}"
  name   = "kms-write-regional"
  policy = "${data.aws_iam_policy_document.kms-write-regional.json}"
}

resource "aws_iam_role_policy" "kms-write-all-regions" {
  count      = "${local.enable_kms * local.all_regions_enabled}"
  role       = "${aws_iam_role.poweruser.name}"
  policy = "${var.aws_iam_policy_document.kms-write.json}"
}
