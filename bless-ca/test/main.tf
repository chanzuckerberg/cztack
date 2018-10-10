provider "bless" {
  region  = "${var.region}"
  profile = "${var.bless_provider_aws_profile}"
}

module "bless" {
  source = ".."

  project = "${var.project}"
  service = "${var.service}"
  env     = "${var.env}"
  owner   = "${var.owner}"

  iam_path                      = "${var.iam_path}"
  aws_account_id                = "${var.aws_account_id}"
  authorized_users              = ["${var.authorized_users}"]
  kmsauth_iam_group_name_format = "${var.kmsauth_iam_group_name_format}"
  bless_logging_level           = "${var.bless_logging_level}"
  region                        = "${var.region}"
}
