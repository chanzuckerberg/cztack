terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.14.0"
    }
  }
  required_version = ">= 1.0"
}
