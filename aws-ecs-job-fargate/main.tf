locals {
  name = "${var.project}-${var.env}-${var.service}"

  container_name = var.container_name == null ? local.name : var.container_name

  task_definition = "${aws_ecs_task_definition.job.family}:${aws_ecs_task_definition.job.revision}"

  tags = {
    managedBy = "terraform"
    Name      = local.name
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
  }
}

# Only one of the following is active at a time, depending on var.manage_task_definition
resource "aws_ecs_service" "job" {
  name        = local.name
  cluster     = var.cluster_id
  count       = var.manage_task_definition ? 1 : 0
  launch_type = "FARGATE"

  task_definition                    = local.task_definition
  desired_count                      = var.desired_count
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  scheduling_strategy                = "REPLICA"

  network_configuration {
    subnets         = var.task_subnets
    security_groups = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy
    content {
      type  = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }

  tags = var.tag_service ? local.tags : {}
}

resource "aws_ecs_service" "unmanaged-job" {
  name        = local.name
  cluster     = var.cluster_id
  count       = var.manage_task_definition ? 0 : 1
  launch_type = "FARGATE"

  task_definition                    = local.task_definition
  desired_count                      = var.desired_count
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  scheduling_strategy                = "REPLICA"

  network_configuration {
    subnets         = var.task_subnets
    security_groups = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy
    content {
      type  = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }

  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = var.tag_service ? local.tags : {}
}

# Default container definition if var.manage_task_definition == false
# Defaults to a minimal hello-world implementation; should be updated separately from
# Terraform, e.g. using ecs deploy or czecs
locals {
  template = <<TEMPLATE
[
  {
    "name": "${local.container_name}",
    "image": "library/busybox:1.29",
    "command": ["sh", "-c", "while true; do { echo -e 'HTTP/1.1 200 OK\r\n\nRunning stub server'; date; } | nc -l -p 8080; done"]
  }
]
TEMPLATE
}

resource "aws_ecs_task_definition" "job" {
  family                   = local.name
  container_definitions    = var.manage_task_definition ? var.task_definition : local.template
  task_role_arn            = var.task_role_arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.task_execution_role.arn
}
