locals {
  service_name = "${var.project}-${var.env}-${var.service}"
}

data "aws_ssm_parameter" "secret" {
  # https://github.com/hashicorp/terraform/issues/22281#issuecomment-517080564
  for_each = { for v in var.parameters : v => v }
  name     = "/${local.service_name}/${each.key}"
}
