resource "aws_ecr_pull_through_cache_rule" "this" {
  ecr_repository_prefix = var.prefix
  upstream_registry_url = var.upstream_registry_url
  credential_arn        = var.secrets_manager_arn
}