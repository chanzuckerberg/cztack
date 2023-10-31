provider "aws" {
  alias  = "logs_destination"
  region = var.destination_account_region

  assume_role {
    role_arn = "arn:aws:iam::${var.destination_account_id}:role/${var.destination_account_assume_role_name}"
  }

  allowed_account_ids = [var.destination_account_id]
}