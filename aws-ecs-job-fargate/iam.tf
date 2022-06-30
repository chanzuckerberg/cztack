data "aws_iam_policy_document" "execution_role" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Always create and attach, Fargate requires task definition to have execution role ARN to support log driver awslogs.
resource "aws_iam_role" "task_execution_role" {
  name               = "${local.name}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.execution_role.json
  tags               = local.tags
}

# TODO(mbarrien): We can probably narrow this down to allowing access to only
# the specific ECR arn if applicable, and the specific cloudwatch log group.
# Either pass both identifiers in, or pass the entire role ARN as an argument
resource "aws_iam_role_policy_attachment" "task_execution_role" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "registry_secretsmanager" {
  count = var.registry_secretsmanager_arn != null ? 1 : 0

  statement {
    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [var.registry_secretsmanager_arn]
  }
}

resource "aws_iam_role_policy" "task_execution_role_secretsmanager" {
  count  = var.registry_secretsmanager_arn != null ? 1 : 0
  role   = aws_iam_role.task_execution_role.name
  policy = data.aws_iam_policy_document.registry_secretsmanager[0].json
}

data "aws_iam_policy_document" "ssm_permission" {
  count = var.ssm_arn != null ? 1 : 0

  statement {
    actions = [
      "ssm:GetParameters",
    ]

    resources = [var.ssm_arn]
  }
}

resource "aws_iam_policy" "task_execution_role_ssm_permission" {
  count  = var.ssm_arn != null ? 1 : 0
  policy = data.aws_iam_policy_document.ssm_permission[0].json
}

resource "aws_iam_role_policy_attachment" "task_execution_role_ssm_attachment" {
  count      = var.ssm_arn != null ? 1 : 0
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.task_execution_role_ssm_permission[0].arn
}