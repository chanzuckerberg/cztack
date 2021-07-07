terraform {
  required_providers {
    # aws_acm_certificate changed API in 3.0.0
    aws = ">= 3.0.0"
  }
}
