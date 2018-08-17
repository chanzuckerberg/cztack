locals {
  log_group_name = "${length(var.log_group_name) > 0 ? var.log_group_name : "${var.project}-${var.env}-${var.service}"}"
}

resource "aws_cloudwatch_log_group" "group" {
  name = "${local.log_group_name}"

  tags {
    project   = "${var.project}"
    env       = "${var.env}"
    service   = "${var.service}"
    owner     = "${var.owner}"
    managedBy = "terraform"
  }
}
