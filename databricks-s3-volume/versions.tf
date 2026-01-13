terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    databricks = {
      source                = "databricks/databricks"
      configuration_aliases = [databricks.mws, databricks.workspace]
    }
  }
  required_version = ">= 1.3.0"
}
