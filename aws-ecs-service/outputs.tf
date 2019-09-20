output "alb_dns_name" {
  value = aws_alb.service.dns_name
}

output "alb_route53_zone_id" {
  value = aws_alb.service.zone_id
}

output "ecs_task_definition_family" {
  description = "The family of the task definition defined for the given/generated container definition."
  value       = aws_ecs_task_definition.job.family
}

output "private_service_discovery_domain" {
  description = "Domain name for service discovery, if with_service_discovery=true. Only resolvable within the VPC."
  value       = "${coalescelist(aws_service_discovery_service.discovery.*.name, [""])[0]}${var.with_service_discovery ? "." : ""}${coalescelist(aws_service_discovery_private_dns_namespace.discovery.*.name, [""])[0]}"
}

output "alb_access_logs_prefix" {
  description = "ALB access logs S3 prefix"
  value       = local.access_logs_prefix
}
