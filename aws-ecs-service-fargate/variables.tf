variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "service" {
  type        = string
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "owner" {
  type        = string
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags that will be added to components created by this module."
  default     = {}
}

variable "cluster_id" {
  type = string
}

variable "desired_count" {
  type = number
}

variable "lb_subnets" {
  description = "List of subnets in which to deploy the load balancer."
  type        = list(string)
}

variable "vpc_id" {
  type = string
}

variable "container_name" {
  description = "Name of the container. Must match name in task definition. If omitted, defaults to name derived from project/env/service."
  type        = string
  default     = null
}

variable "container_port" {
  description = "The port the container to be exposed to is listening on."
  type        = number
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "route53_zone_id" {
  description = "Zone in which to create an alias record to the ALB."
  type        = string
}

variable "subdomain" {
  description = "Subdomain in the zone. Final domain name will be subdomain.zone"
  type        = string
}

variable "task_role_arn" {
  type = string
}

variable "task_definition" {
  description = "JSON to describe task. If omitted, defaults to a stub task that is expected to be managed outside of Terraform."
  type        = string
  default     = null
}

variable "acm_certificate_arn" {
  description = "Certificate for the HTTPS listener."
  type        = string
}

variable "ssl_policy" {
  description = "ELB policy to determine which SSL/TLS encryption protocols are enabled. Probably don't touch this."
  type        = string
  default     = null
}

variable "task_subnets" {
  description = "List of subnets in which to deploy the task for awsvpc networking mode."
  type        = list(string)
  default     = []
}

variable "task_egress_cidrs" {
  type        = list(string)
  description = "CIDRs the task is allowed to communicate with for outbound traffic."
  default     = ["0.0.0.0/0"]
}

variable "task_egress_security_group_ids" {
  type        = list(string)
  description = "Security groups the task is allowed to communicate with for outbound traffic. Only used if awsvpc_network is true."
  default     = []
}

variable "lb_ingress_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "lb_ingress_security_group_ids" {
  type    = list(string)
  default = []
}

variable "lb_idle_timeout_seconds" {
  type    = number
  default = 60
}

variable "internal_lb" {
  type    = bool
  default = false
}

variable "health_check_matcher" {
  type        = string
  description = "Range of HTTP status codes considered success for health checks. [Doc](https://www.terraform.io/docs/providers/aws/r/lb_target_group.html#matcher)"
  default     = "200-399"
}

variable "disable_http_redirect" {
  description = "Disable redirecting HTTP to HTTPS."
  default     = true
}

variable "health_check_timeout" {
  description = "Timeout for a health check of the underlying service."
  type        = number
  default     = null
}

variable "health_check_interval" {
  description = "Time between health checks of the underlying service."
  type        = number
  default     = null
}

variable "health_check_grace_period_seconds" {
  type        = number
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200."
  default     = 60
}

variable "cpu" {
  description = "CPU units for Fargate task. Used if task_definition provided, or for initial stub task if externally managed."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory in megabytes for Fargate task. Used if task_definition provided, or for initial stub task if externally managed."
  type        = number
  default     = 512
}

variable "registry_secretsmanager_arn" {
  description = "ARN for AWS Secrets Manager secret for credentials to private registry"
  type        = string
  default     = null
}

variable "with_service_discovery" {
  description = "Register the service with ECS service discovery. Adds a sub-zone to the given route53_zone_id."
  type        = bool
  default     = false
}

variable "access_logs_bucket" {
  description = "S3 bucket to write alb access logs to. Null for no access logs."
  type        = string
  default     = null
}

variable "manage_task_definition" {
  description = "If false, Terraform will not touch the task definition for the ECS service after initial creation"
  type        = bool
  default     = true
}

variable "tag_service" {
  description = "Apply cost tags to the ECS service. Only specify false for backwards compatibility with old ECS services."
  type        = bool
  default     = true
}

variable "ordered_placement_strategy" {
  type        = list(object({ type = string, field = string }))
  default     = []
  description = "Placement strategy for the task instances."
}

variable "volumes" {
  type        = list(any)
  default     = []
  description = "Volumes defined per the efs task definition [docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#volume)"
}
