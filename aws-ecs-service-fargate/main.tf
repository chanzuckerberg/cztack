locals {
  name = format("%.32s", "${var.project}-${var.env}-${var.service}")

  default_tags = {
    managedBy = "terraform"
    Name      = local.name
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
  }

  tags = merge(var.extra_tags, local.default_tags)
}
