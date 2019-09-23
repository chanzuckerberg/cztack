resource "aws_service_discovery_private_dns_namespace" "discovery" {
  count       = var.with_service_discovery ? 1 : 0
  name        = "${local.name}.terraform.local"
  description = "Namespace for service discovery for ${local.name}"
  vpc         = var.vpc_id
}

resource "aws_service_discovery_service" "discovery" {
  count       = var.with_service_discovery ? 1 : 0
  name        = local.name
  description = "Service discovery for ${local.name}"

  health_check_custom_config {
    failure_threshold = 1
  }

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.discovery[0].id

    dns_records {
      ttl  = 10
      type = "A"
    }
  }
}
