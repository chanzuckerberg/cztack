terraform {
  required_version = ">= 1.3"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.51"
    }
  }
}
