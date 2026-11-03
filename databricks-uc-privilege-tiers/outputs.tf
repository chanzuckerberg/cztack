output "tiers" {
  description = "Privilege tiers keyed by short code. Each tier has a group name `suffix` and a privilege list per level (`catalog`, `schema`, `volume`); null means the tier doesn't exist at that level."
  value       = local.tiers
}

output "levels" {
  description = "Short codes of the tiers that exist at each level, keyed by level."
  value       = local.levels
}