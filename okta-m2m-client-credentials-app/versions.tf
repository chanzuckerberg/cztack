terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.14"
    }
    jwks = {
      source  = "iwarapter/jwks"
      version = ">= 0.0.3"
    }
  }

  required_version = ">= 1.3"
}
