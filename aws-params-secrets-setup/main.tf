resource "aws_kms_key" "parameter_store" {
  description             = "Parameter store kms master key"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    project   = "${var.project}"
    env       = "${var.env}"
    service   = "${var.service}"
    owner     = "${var.owner}"
    managedBy = "terraform"
  }
}

# Chamber is hard coded to use a KMS alias with the exact name
# "parameter_store_alias" when writing; this is how we enforce
# encryption and access control for specific keys
resource "aws_kms_alias" "parameter_store_alias" {
  name          = "alias/${var.alias_name}"
  target_key_id = "${aws_kms_key.parameter_store.id}"
}
