locals {
  cluster_log_bucket_prefix = "databricks-cluster-logs"
}

data "aws_iam_policy_document" "databricks-setup-assume-role" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.databricks_aws_account}:root"]
    }

    actions = ["sts:AssumeRole"]
    condition {
      test     = "StringLike"
      variable = "sts:ExternalId"
      values   = [var.databricks_external_id]
    }
  }
}

resource "aws_iam_role" "databricks" {
  name               = local.name
  assume_role_policy = data.aws_iam_policy_document.databricks-setup-assume-role.json
  tags               = local.tags
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid = "NonResourceBasedPermissions"
    actions = [
      "ec2:CancelSpotInstanceRequests",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeIamInstanceProfileAssociations",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInstances",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNatGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribePlacementGroups",
      "ec2:DescribePrefixLists",
      "ec2:DescribeReservedInstancesOfferings",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSpotInstanceRequests",
      "ec2:DescribeSpotPriceHistory",
      "ec2:DescribeSubnets",
      "ec2:DescribeVolumes",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcs",
      "ec2:CreatePlacementGroup",
      "ec2:DeletePlacementGroup",
      "ec2:CreateKeyPair",
      "ec2:DeleteKeyPair",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:RequestSpotInstances",
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/databricks/*"]
  }

  dynamic "statement" {
    for_each = length(var.passable_role_arn) > 0 ? [1] : []

    content {
      actions = [
        "iam:PassRole"
      ]
      resources = [
        var.passable_role_arn
      ]
    }
  }

  statement {
    sid = "InstancePoolsSupport"
    actions = [
      "ec2:AssociateIamInstanceProfile",
      "ec2:DisassociateIamInstanceProfile",
      "ec2:ReplaceIamInstanceProfileAssociation",
    ]

    resources = ["${local.ec2_arn_base}:instance/*"]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid = "AllowEc2RunInstancePerTag"
    actions = [
      "ec2:RunInstances",
    ]

    resources = [
      "${local.ec2_arn_base}:instance/*",
      "${local.ec2_arn_base}:volume/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid = "AllowEc2RunInstanceImagePerTag"
    actions = [
      "ec2:RunInstances",
    ]

    resources = [
      "${local.ec2_arn_base}:image/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid = "AllowEc2RunInstancePerVPCid"
    actions = [
      "ec2:RunInstances",
    ]

    resources = [
      "${local.ec2_arn_base}:network-interface/*",
      "${local.ec2_arn_base}:subnet/*",
      "${local.ec2_arn_base}:security-group/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:vpc"
      values   = ["${local.ec2_arn_base}:vpc/${var.vpc_id}"]
    }
  }

  statement {
    sid = "AllowEc2RunInstanceOtherResources"
    actions = [
      "ec2:RunInstances",
    ]

    not_resources = [
      "${local.ec2_arn_base}:image/*",
      "${local.ec2_arn_base}:network-interface/*",
      "${local.ec2_arn_base}:subnet/*",
      "${local.ec2_arn_base}:security-group/*",
      "${local.ec2_arn_base}:volume/*",
      "${local.ec2_arn_base}:instance/*"
    ]
  }

  statement {
    sid = "EC2TerminateInstancesTag"
    actions = [
      "ec2:TerminateInstances",
    ]

    resources = [
      "${local.ec2_arn_base}:instance/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid = "EC2AttachDetachVolumeTag"
    actions = [
      "ec2:AttachVolume",
      "ec2:DetachVolume",
    ]

    resources = [
      "${local.ec2_arn_base}:instance/*",
      "${local.ec2_arn_base}:volume/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid = "EC2CreateVolumeByTag"
    actions = [
      "ec2:CreateVolume",
    ]

    resources = [
      "${local.ec2_arn_base}:volume/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid = "EC2DeleteVolumeByTag"
    actions = [
      "ec2:DeleteVolume",
    ]

    resources = [
      "${local.ec2_arn_base}:volume/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:PutRolePolicy",
    ]

    resources = [
      "arn:aws:iam::*:role/aws-service-role/spot.amazonaws.com/AWSServiceRoleForEC2Spot",
    ]

    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values   = ["spot.amazonaws.com"]
    }

    effect = "Allow"
  }

  statement {
    sid = "VpcNonresourceSpecificActions"
    actions = [
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
    ]

    resources = [
      "${local.ec2_arn_base}:security-group/${aws_security_group.databricks.id}",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:vpc"
      values   = ["${local.ec2_arn_base}:vpc/${var.vpc_id}"]
    }
  }
}

resource "aws_iam_role_policy" "policy" {
  name   = "extras"
  role   = aws_iam_role.databricks.id
  policy = data.aws_iam_policy_document.policy.json
}
