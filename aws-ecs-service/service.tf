locals {
  container_name = var.container_name == null ? local.name : var.container_name

  task_definition = "${aws_ecs_task_definition.job.family}:${aws_ecs_task_definition.job.revision}"
}

# Only one of the following is active at a time, depending on var.manage_task_definition
resource "aws_ecs_service" "job" {
  name    = local.name
  cluster = var.cluster_id
  count   = var.manage_task_definition ? 1 : 0

  task_definition                   = local.task_definition
  desired_count                     = var.desired_count
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  load_balancer {
    target_group_arn = aws_lb_target_group.service.arn
    container_name   = local.container_name
    container_port   = var.container_port
  }

  dynamic "service_registries" {
    for_each = aws_service_discovery_service.discovery[*]
    content {
      registry_arn = service_registries.arn
    }
  }

  tags = local.tags

  depends_on = [aws_lb.service]
}

resource "aws_ecs_service" "unmanaged-job" {
  name    = local.name
  cluster = var.cluster_id
  count   = var.manage_task_definition ? 0 : 1

  task_definition                   = local.task_definition
  desired_count                     = var.desired_count
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  load_balancer {
    target_group_arn = aws_lb_target_group.service.arn
    container_name   = local.container_name
    container_port   = var.container_port
  }

  dynamic "service_registries" {
    for_each = aws_service_discovery_service.discovery[*]
    content {
      registry_arn = aws_service_discovery_service.discovery[0].arn
    }
  }

  # This lifecycle block is the only difference between job and unmanaged-job
  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = local.tags

  depends_on = [aws_lb.service]
}

# Default container definition if manage_task_definition == false.
# Defaults to a minimal hello-world implementation; should be updated separately from
# Terraform, e.g. using ecs deploy or czecs

locals {
  dummy_task = <<TEMPLATE
[
  {
    "name": "${local.container_name}",
    "image": "library/busybox:1.29",
    "command": ["sh", "-c", "while true; do { echo -e 'HTTP/1.1 200 OK\r\n\nRunning stub server'; date; } | nc -l -p ${var.container_port}; done"],
    "memoryReservation": 4,
    "portMappings": [
      {
        "containerPort": ${var.container_port},
        "hostPort": 0
      }
    ]
  }
]
TEMPLATE
}

resource "aws_ecs_task_definition" "job" {
  family                = local.name
  container_definitions = var.manage_task_definition ? var.task_definition : local.dummy_task
  task_role_arn         = var.task_role_arn
  tags                  = local.tags
  execution_role_arn    = var.registry_secretsmanager_arn == null ? null : aws_iam_role.task_execution_role[0].arn
}
