locals {
  service_name = "${var.project}-${var.env}-${var.service}"
}

data "aws_kms_key" "key" {
  key_id = "alias/parameter_store_key"
}

resource "aws_ssm_parameter" "parameter" {
  count = "${var.parameters_count}"

  name  = "/${local.service_name}/${element(keys(var.parameters), count.index)}"
  value = "${lookup(var.parameters, element(keys(var.parameters), count.index))}"

  type      = "SecureString"
  key_id    = "${data.aws_kms_key.key.id}"
  overwrite = "true"

  tags = {
    managedBy = "terraform"
    project   = "${var.project}"
    env       = "${var.env}"
    service   = "${var.service}"
    owner     = "${var.owner}"
  }
}
