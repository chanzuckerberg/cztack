locals {
  read_write_arns = concat(var.read_arns, var.write_arns)
  lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep at most ${var.max_image_count} images",
        selection = {
          tagStatus   = "any",
          countType   = "imageCountMoreThan",
          countNumber = var.max_image_count
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "repo" {
  name         = var.name
  tags         = var.tags
  force_delete = var.force_delete

  image_tag_mutability = var.allow_tag_mutability ? "MUTABLE" : "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = var.enable_image_scan_on_push
  }
  lifecycle {
    ignore_changes = [name]
  }
}


resource "aws_ecr_repository_policy" "policy" {
  # We need to make sure there are available ARNs for the policy to attach to.
  # Create if there is at least read/write arn or have a non-empty JSON policy
  count = (length(local.read_write_arns) > 0 || var.ecr_resource_policy != null) ? 1 : 0

  repository = aws_ecr_repository.repo.name
  policy     = data.aws_iam_policy_document.policy.json
}

data "aws_iam_policy_document" "policy" {

  dynamic "statement" {
    for_each = var.allow_lambda_pull ? { "principal" : "lambda.amazonaws.com" } : {}
    content {
      sid = "LambdaECRImageRetrievalPolicy"
      actions = [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:SetRepositoryPolicy",
        "ecr:DeleteRepositoryPolicy",
        "ecr:GetRepositoryPolicy",
      ]
      principals {
        type        = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }
  }
  dynamic "statement" {
    for_each = length(local.read_write_arns) > 0 ? [local.read_write_arns] : []
    iterator = arns
    content {
      sid = "Read"

      principals {
        type        = "AWS"
        identifiers = arns.value
      }

      actions = [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
      ]
    }
  }

  dynamic "statement" {
    for_each = var.write_arns
    iterator = arn
    content {
      sid = "Write${arn.key}"

      principals {
        type        = "AWS"
        identifiers = [arn.value]
      }

      actions = [
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
      ]
    }
  }

  source_policy_documents = var.ecr_resource_policy == null || var.ecr_resource_policy == "" ? [] : [var.ecr_resource_policy]
}

resource "aws_ecr_lifecycle_policy" "lifecycle" {
  repository = aws_ecr_repository.repo.name
  policy     = var.lifecycle_policy == "" ? local.lifecycle_policy : var.lifecycle_policy
}
