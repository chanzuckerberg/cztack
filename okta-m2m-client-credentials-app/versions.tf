terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 6.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    jwks = {
      source  = "iwarapter/jwks"
      version = "~> 0.0"
    }
  }

  required_version = ">= 1.3"
}
