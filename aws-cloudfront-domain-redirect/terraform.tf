terraform {
  # Uses aws-acm-certificate module, which needs AWS provider >3.0
  required_providers {
    aws = ">= 3.0.0"
  }
}
