output "catalogs" {
  description = "Map of created Databricks catalogs, keyed by catalog name"
  value       = databricks_catalog.catalog
}

output "catalog_groups" {
  description = "Map of created Databricks catalog groups, keyed by catalog name"
  value       = local.catalog_group_map
}

output "external_location" {
  description = "The Databricks external location"
  value       = databricks_external_location.external_locations
}
