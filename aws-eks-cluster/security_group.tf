# Per https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group, using both inline
# security group rules and aws_security_group_rule resources conflict with one another. We should only use one method
# to specify security group rules.
resource "aws_security_group" "cluster" {
  name        = "${local.cluster_name}-cluster-sg"
  description = "Security group for ${local.cluster_name} cluster"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "allow_all_cluster_egress" {
  type              = "egress"
  security_group_id = aws_security_group.cluster.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all egress traffic"
}

resource "aws_security_group" "node" {
  name        = "${local.cluster_name}-node-sg"
  description = "Security group for ${local.cluster_name} cluster nodes"
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { "karpenter.sh/discovery" = local.cluster_name })
}

resource "aws_security_group_rule" "allow_all_node_egress" {
  type              = "egress"
  security_group_id = aws_security_group.node.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all egress traffic"
}

resource "aws_security_group_rule" "node_to_node_ingress" {
  type                     = "ingress"
  security_group_id        = aws_security_group.node.id
  source_security_group_id = aws_security_group.node.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  description              = "Allow node to node ingress communication"
}

resource "aws_security_group_rule" "node_to_node_egress" {
  type                     = "egress"
  security_group_id        = aws_security_group.node.id
  source_security_group_id = aws_security_group.node.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  description              = "Allow node to node egress communication"
}


resource "aws_security_group_rule" "cluster_to_node" {
  type                     = "ingress"
  security_group_id        = aws_security_group.node.id
  source_security_group_id = aws_security_group.cluster.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  description              = "Allow cluster to node communication"
}

resource "aws_security_group_rule" "node_to_cluster" {
  type                     = "ingress"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.node.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  description              = "Allow node to cluster control plane communication"
}

resource "aws_security_group_rule" "cluster_to_cluster" {
  type                     = "ingress"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.cluster.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  description              = "Allow intra-cluster control plane communication"
}
