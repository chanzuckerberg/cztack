locals {
  service_name = "${var.project}-${var.env}-${var.service}"
}

data "aws_kms_key" "key" {
  key_id = "alias/parameter_store_key"
}

resource "aws_ssm_parameter" "parameter" {
  for_each = var.parameters
  name     = "/${local.service_name}/${each.key}"
  value    = each.value

  type      = "SecureString"
  key_id    = data.aws_kms_key.key.id
  overwrite = true

  tags = {
    managedBy = "terraform"
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
  }
}
