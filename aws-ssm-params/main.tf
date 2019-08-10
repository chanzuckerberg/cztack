locals {
  service_name = "${var.project}-${var.env}-${var.service}"
}

data "aws_ssm_parameter" "secret" {
  for_each = toset(var.parameters)
  name     = "/${local.service_name}/${each.key}"
}
