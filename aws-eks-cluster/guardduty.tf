data "aws_region" "current" {}
resource "aws_security_group" "guardduty" {
  count       = var.addons.enable_guardduty ? 1 : 0
  name        = substr("gvat-${module.cluster.cluster_name}", 0, 63) // gvat = guardduty_vpce_allow_tls
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_vpc_endpoint" "guardduty" {
  count               = var.addons.enable_guardduty ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.guardduty-data"
  subnet_ids          = var.subnet_ids
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.guardduty[0].id]
  private_dns_enabled = true

  tags = var.tags
}

resource "aws_eks_addon" "guardduty" {
  count                       = var.addons.enable_guardduty ? 1 : 0
  addon_name                  = "aws-guardduty-agent"
  cluster_name                = module.cluster.cluster_name
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  tags                        = var.tags
  depends_on = [
    module.cluster, aws_vpc_endpoint.guardduty
  ]
}