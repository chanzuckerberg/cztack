provider "databricks" {
  alias      = "mws"
  host       = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_external_id
}

provider "databricks" {
  alias = "workspace"
  host  = var.workspace_url
}
