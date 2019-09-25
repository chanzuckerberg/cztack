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
}

# TODO: Add support for giving permissions to ECR ARNs and possibly cloudwatch log group
# Or provide ability to pass in own execution role ARN
resource "aws_iam_role_policy_attachment" "task_execution_role" {
  count      = var.registry_secretsmanager_arn != null ? 1 : 0
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "registry_secretsmanager" {
  count = var.registry_secretsmanager_arn != null ? 1 : 0

  statement {
    actions = [
      "kms:Decrypt",
    ]

    resources = [var.registry_secretsmanager_arn]
  }

  statement {
    actions = [
      "secretsmanager:GetSecretValue",
    ]

    # Limit to only current version of the secret
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "secretsmanager:VersionStage"
      values   = ["AWSCURRENT"]
    }

    resources = [var.registry_secretsmanager_arn]
  }
}

resource "aws_iam_role_policy" "task_execution_role_secretsmanager" {
  count  = var.registry_secretsmanager_arn != null ? 1 : 0
  role   = aws_iam_role.task_execution_role.name
  policy = data.aws_iam_policy_document.registry_secretsmanager[0].json
}
