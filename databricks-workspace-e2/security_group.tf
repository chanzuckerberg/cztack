resource "aws_security_group" "databricks" {
  name        = local.name
  description = "self tcp and udp all ports and all outbound"
  vpc_id      = var.vpc_id

  ingress {
    description = "self tcp all ports"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "self udp all ports"
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}
