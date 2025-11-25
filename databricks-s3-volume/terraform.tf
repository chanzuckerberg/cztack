terraform {
  required_providers {
    databricks = {
      source              = "databricks/databricks"
      version             = "1.49.1"
      configuration_aliases = [ databricks.mws, databricks.workspace ]
    }
  }
}
