locals {
  role_name = coalescelist(aws_iam_role.role[*].name, [var.existing_role_name])[0]
}

data "aws_iam_policy_document" "assume-role" {
  statement {
    sid     = "AssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  count              = var.create_role ? 1 : 0
  name_prefix        = var.name_prefix
  description        = var.role_description
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.assume-role.json

  lifecycle {
    ignore_changes = [name, name_prefix, path]
  }
}

resource "aws_iam_role_policy_attachment" "cloudwatch-agent" {
  role       = local.role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "profile" {
  name_prefix = var.name_prefix
  path        = var.iam_path
  role        = local.role_name

  lifecycle {
    ignore_changes = [name, name_prefix, path]
  }
}
