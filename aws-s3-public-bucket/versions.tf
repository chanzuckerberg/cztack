terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.29.0"
    }
  }
  required_version = ">= 1.0"
}
