provider "bless" {
  region  = "${var.region}"
  profile = "${var.bless_provider_aws_profile}"
}

# create a dummy user to test
resource "aws_iam_user" "bless-test" {
  name = "${var.test_user_name}"
  path = "${var.iam_path}"
}

module "bless" {
  source = "./.."

  project = "${var.project}"
  service = "${var.service}"
  env     = "${var.env}"
  owner   = "${var.owner}"

  iam_path                      = "${var.iam_path}"
  authorized_users              = ["${aws_iam_user.bless-test.arn}"]
  kmsauth_iam_group_name_format = "${var.kmsauth_iam_group_name_format}"
  bless_logging_level           = "${var.bless_logging_level}"
}
