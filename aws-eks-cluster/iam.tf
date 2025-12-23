locals {
  // NOTE: coalesce() doesn't work here because it doesn't handle empty strings the way we intend -- iam_cluster_name_prefix can be passed as an empty string,
  // and this value has to be honored, when the cluster_name is not set.
  name_prefix = var.cluster_name == "" ? var.cluster_name : (var.iam_cluster_name_prefix != null ? var.iam_cluster_name_prefix : var.cluster_name)
}
data "aws_iam_policy_document" "cluster" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "node" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cluster" {
  assume_role_policy    = data.aws_iam_policy_document.cluster.json
  force_detach_policies = true
  name_prefix           = "${local.name_prefix}-eks-cluster"

  tags = var.tags
}

resource "aws_iam_role" "node" {
  assume_role_policy    = data.aws_iam_policy_document.node.json
  force_detach_policies = true
  name_prefix           = "${local.name_prefix}-eks-node"

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "cluster" {
  for_each = toset(["AmazonEKSClusterPolicy", "AmazonEKSVPCResourceController"])

  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "node" {
  for_each = toset(["AmazonEC2ContainerRegistryReadOnly", "AmazonEKSWorkerNodePolicy", "AmazonEKS_CNI_Policy", "AmazonSSMManagedInstanceCore"])

  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_ecr_pullthrough_cache_attachment" {
  policy_arn = aws_iam_policy.node_ecr_pullthrough_cache.arn
  role       = aws_iam_role.node.name
}

