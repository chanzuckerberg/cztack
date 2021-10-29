locals {
  tags = {
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
    managedBy = "terraform"
    Name      = var.volume_name 
  }
}

resource "aws_efs_file_system" "efs" {
  creation_token = var.volume_name
  encrypted      = true
  kms_key_id     = var.kms_key_id
  tags           = merge(local.tags, { Name = var.volume_name })
}

resource "aws_efs_mount_target" "efs" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = [aws_security_group.efs.id]
}

resource "aws_security_group" "efs" {
  name        = "efs-${var.volume_name}"
  description = "Allows NFS traffic from instances in a given security group."
  vpc_id      = var.vpc_id

  ingress = [
    {
      from_port       = 2049
      to_port         = 2049
      protocol        = "tcp"
      security_groups = var.security_groups
      cidr_blocks     = var.cidr_blocks
    }
  ]

  egress = [
    {
      from_port       = 2049
      to_port         = 2049
      protocol        = "tcp"
      security_groups = var.security_groups
      cidr_blocks     = var.cidr_blocks
    }
  ]

  tags = local.tags
}
