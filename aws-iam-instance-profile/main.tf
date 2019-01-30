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
  name_prefix        = "${var.name_prefix}"
  description        = "${var.role_description}"
  path               = "${var.iam_path}"
  assume_role_policy = "${data.aws_iam_policy_document.assume-role.json}"

  lifecycle {
    ignore_changes = ["name", "name_prefix", "path"]
  }
}

resource "aws_iam_role_policy" "ssm" {
  count  = "${var.enable_ssm ? 1 : 0}"
  role   = "${aws_iam_role.role.name}"
  policy = "${data.aws_iam_policy_document.ssm_policy.json}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch-agent" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "profile" {
  name_prefix = "${var.name_prefix}"
  path        = "${var.iam_path}"
  role        = "${aws_iam_role.role.name}"

  lifecycle {
    ignore_changes = ["name", "name_prefix", "path"]
  }
}

data "aws_iam_policy_document" "ssm_policy" {
  statement {
    actions = [
      "ssm:DescribeAssociation",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:DescribeDocument",
      "ssm:GetManifest",
      "ssm:GetParameters",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:PutInventory",
      "ssm:PutComplianceItems",
      "ssm:PutConfigurePackageResult",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply",
    ]

    resources = ["*"]
  }

  statement {
    actions = ["cloudwatch:PutMetricData"]

    resources = ["*"]
  }

  statement {
    actions = ["ec2:DescribeInstanceStatus"]

    resources = ["*"]
  }

  statement {
    actions = [
      "ds:CreateComputer",
      "ds:DescribeDirectories",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    //https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent-minimum-s3-permissions.html
    resources = [
      "arn:aws:s3:::aws-ssm-*/*",
      "arn:aws:s3:::aws-windows-downloads-*/*",
      "arn:aws:s3:::amazon-ssm-*/*",
      "arn:aws:s3:::amazon-ssm-packages-*/*",
      "arn:aws:s3:::*-birdwatcher-prod/*",
      "arn:aws:s3:::patch-baseline-snapshot-*/*",
    ]
  }
}
