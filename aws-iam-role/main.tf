locals {
  tags = {
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
    managedBy = "terraform"
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    dynamic principals {
      for_each = var.principals
      content {
        type        = principals.value.type
        identifiers = principals.value.identifiers
      }
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = var.role_name
  description        = var.role_description
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = local.tags
}

resource "aws_iam_role_policy" "policy" {
  for_each = { for policy in var.inline_policies : policy.name => policy }
  name     = each.value.name
  role     = aws_iam_role.role.id
  policy   = each.value.policy
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each   = toset(var.attached_policies_arns)
  role       = aws_iam_role.role.id
  policy_arn = each.value
}
