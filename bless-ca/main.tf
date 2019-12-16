locals {
  name = "${var.project}-${var.env}-${var.service}"

  tags = {
    managedBy = "terraform"
    project   =  var.project
    env       =  var.env
    owner     =  var.owner
    service   =  var.service
  }
}
