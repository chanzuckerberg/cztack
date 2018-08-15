locals {
  service_name = "${var.project}-${var.env}-${var.service}"
}

data "aws_ssm_parameter" "secret" {
  name = "${var.use_paths == "true" ? "/" : ""}${local.service_name}${var.use_paths == "true" ? "/" : "."}${var.name}"
}
