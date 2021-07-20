locals {
  access_logs_prefix = var.access_logs_bucket == null ? "" : local.name

  ingress_rules = ["https-443-tcp", "http-80-tcp"]

  # Default to allowing TLS 1.1 on external facing services, disabling and only allowing TLS 1.2 for internal
  ssl_policy = compact([var.ssl_policy, var.internal_lb ? "ELBSecurityPolicy-TLS-1-2-2017-01" : "ELBSecurityPolicy-TLS-1-1-2017-01"])[0]
}

resource "aws_lb_target_group" "service" {
  name        = local.name
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = var.awsvpc_network_mode ? "ip" : "instance"

  deregistration_delay = 60
  slow_start           = var.slow_start

  health_check {
    path     = var.health_check_path
    matcher  = var.health_check_matcher
    timeout  = var.health_check_timeout
    interval = var.health_check_interval
  }

  tags = local.tags
}

resource "aws_lb" "service" {
  name            = local.name
  internal        = var.internal_lb
  security_groups = [module.alb-sg.security_group_id]
  subnets         = var.lb_subnets
  idle_timeout    = var.lb_idle_timeout_seconds

  dynamic "access_logs" {
    for_each = compact([var.access_logs_bucket])
    content {
      bucket  = var.access_logs_bucket
      prefix  = local.access_logs_prefix
      enabled = true
    }
  }

  tags = local.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.service.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = var.disable_http_redirect ? "forward" : "redirect"
    target_group_arn = var.disable_http_redirect ? aws_lb_target_group.service.arn : null

    dynamic "redirect" {
      for_each = compact([var.disable_http_redirect ? "" : "present"])
      content {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.service.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.acm_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.service.arn
    type             = "forward"
  }
}

module "alb-sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.3.0"
  name        = "${local.name}-alb"
  description = "Security group for ${var.internal_lb ? "internal" : "internet facing"} ALB"
  vpc_id      = var.vpc_id
  tags        = local.tags

  ingress_with_cidr_blocks = length(var.lb_ingress_cidrs) == 0 ? [] : [
    for rule in local.ingress_rules : {
      cidr_blocks = join(",", var.lb_ingress_cidrs)
      rule        = rule
    }
  ]

  ingress_with_source_security_group_id = [
    for sg_rule in setproduct(var.lb_ingress_security_group_ids, local.ingress_rules) : {
      source_security_group_id = sg_rule[0]
      rule                     = sg_rule[1]
    }
  ]

  egress_with_cidr_blocks = var.awsvpc_network_mode ? [] : [
    {
      cidr_blocks = "0.0.0.0/0"
      rule        = "all-all"
    },
  ]

  egress_with_source_security_group_id = [
    {
      from_port                = var.container_port
      to_port                  = var.container_port
      protocol                 = "tcp"
      description              = "Container port"
      source_security_group_id = module.container-sg.security_group_id
    },
  ]
}
