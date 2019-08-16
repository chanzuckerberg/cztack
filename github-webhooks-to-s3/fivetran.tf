module "fivetran-role" {
  source = "../fivetran_s3_role"

  project = "${var.project}"
  env     = "${var.env}"
  service = "${var.service}"
  owner   = "${var.owner}"

  bucket_name = "${module.bucket.id}"

  bucket_prefix = "/*"
}
