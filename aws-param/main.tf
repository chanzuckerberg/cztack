locals {
  service_name = "${var.project}-${var.env}-${var.service}"
}

data "aws_ssm_parameter" "secret" {
  name = "${var.use_paths ? "/" : ""}${local.service_name}${var.use_paths ? "/" : "."}${var.name}"
}
