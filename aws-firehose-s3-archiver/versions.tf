terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    assert = {
      source = "bwoznicki/assert"
    }
  }
  required_version = ">= 0.13"
}