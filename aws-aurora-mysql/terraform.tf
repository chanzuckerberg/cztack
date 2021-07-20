terraform {
  required_providers {
    # ca_cert_identifier on RDS was added in 2.44.0
    aws = ">= 2.44.0"
  }
}
