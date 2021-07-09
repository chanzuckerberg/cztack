locals {
  container_name = var.container_name == null ? local.name : var.container_name

  task_definition = "${aws_ecs_task_definition.job.family}:${aws_ecs_task_definition.job.revision}"
}

module "container-sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.3.0"
  create      = var.awsvpc_network_mode
  name        = local.name
  description = "ECS ingress port"
  vpc_id      = var.vpc_id
  tags        = local.tags

  ingress_with_source_security_group_id = [
    {
      from_port                = var.container_port
      to_port                  = var.container_port
      protocol                 = "tcp"
      description              = "Container port"
      source_security_group_id = module.alb-sg.security_group_id
    },
  ]

  egress_with_cidr_blocks = length(var.task_egress_cidrs) == 0 ? [] : [
    {
      cidr_blocks = join(",", var.task_egress_cidrs)
      rule        = "all-all"
    },
  ]

  egress_with_source_security_group_id = [
    for sg in var.task_egress_security_group_ids : {
      rule                     = "all-all"
      source_security_group_id = sg
    }
  ]
}

# Only one of the following is active at a time, depending on var.manage_task_definition
resource "aws_ecs_service" "job" {
  name    = local.name
  cluster = var.cluster_id
  count   = var.manage_task_definition ? 1 : 0

  task_definition                   = local.task_definition
  desired_count                     = var.desired_count
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  dynamic "network_configuration" {
    for_each = compact([var.awsvpc_network_mode ? "present" : ""])
    content {
      subnets         = var.task_subnets
      security_groups = [module.container-sg.security_group_id]
    }
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.service.arn
    container_name   = local.container_name
    container_port   = var.container_port
  }

  dynamic "service_registries" {
    for_each = aws_service_discovery_service.discovery[*]
    content {
      registry_arn = service_registries.value.arn
    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy
    content {
      type  = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }

  tags = var.tag_service ? local.tags : {}

  depends_on = [aws_lb.service]
}

resource "aws_ecs_service" "unmanaged-job" {
  name    = local.name
  cluster = var.cluster_id
  count   = var.manage_task_definition ? 0 : 1

  task_definition                   = local.task_definition
  desired_count                     = var.desired_count
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  dynamic "network_configuration" {
    for_each = compact([var.awsvpc_network_mode ? "present" : ""])
    content {
      subnets         = var.task_subnets
      security_groups = [module.container-sg.security_group_id]
    }
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.service.arn
    container_name   = local.container_name
    container_port   = var.container_port
  }

  dynamic "service_registries" {
    for_each = aws_service_discovery_service.discovery[*]
    content {
      registry_arn = service_registries.value.arn
    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy
    content {
      type  = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }

  # This lifecycle block is the only difference between job and unmanaged-job
  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = var.tag_service ? local.tags : {}

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
        "hostPort": ${var.awsvpc_network_mode ? var.container_port : 0}
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
  network_mode          = var.awsvpc_network_mode ? "awsvpc" : null
  execution_role_arn    = var.registry_secretsmanager_arn == null ? null : aws_iam_role.task_execution_role[0].arn
  dynamic "volume" {
    for_each = var.volumes
    content {
      name      = volume.value.name
      host_path = try(volume.value.host_path, null)
      dynamic "docker_volume_configuration" {
        for_each = try(volume.value.docker_volume_configuration, [])
        content {
          scope         = try(docker_volume_configuration.value.scope, null)
          autoprovision = try(docker_volume_configuration.value.autoprovision, null)
          driver        = try(docker_volume_configuration.value.driver, null)
          driver_opts   = try(docker_volume_configuration.value.driver_opts, null)
          labels        = try(docker_volume_configuration.value.labels, null)
        }
      }
      dynamic "efs_volume_configuration" {
        for_each = try(volume.value.efs_volume_configuration, [])
        content {
          file_system_id = try(efs_volume_configuration.value.file_system_id, null)
          root_directory = try(efs_volume_configuration.value.root_directory, null)
          # transit_encryption = try(efs_volume_configuration.value.transit_encryption, null)
        }
      }
    }
  }
}
