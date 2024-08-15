terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    databricks = {
      source = "databricks/databricks"
      version = "1.49.1"
    }
  }
  required_version = ">= 1.3.0"
}
