// https://docs.databricks.com/administration-guide/multiworkspace/iam-role.html#language-Your%C2%A0VPC,%C2%A0custom
locals {
  databricks_aws_account = "414351767826" # Databricks' own AWS account, not CZI's. See https://docs.databricks.com/en/administration-guide/account-settings-e2/credentials.html#step-1-create-a-cross-account-iam-role
  ec2_arn_base           = "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}"
  name                   = coalesce(var.workspace_name_override, "${var.project}-${var.env}-${var.service}")
  security_group_ids     = [aws_security_group.databricks.id]
  tags = {
    project   = var.project
    env       = var.env
    service   = var.service
    owner     = var.owner
    managedBy = "terraform"
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "databricks_mws_networks" "networking" {
  account_id         = var.databricks_external_id
  network_name       = local.name
  vpc_id             = var.vpc_id
  subnet_ids         = var.private_subnets
  security_group_ids = local.security_group_ids
}

resource "databricks_mws_storage_configurations" "databricks" {
  account_id                 = var.databricks_external_id
  storage_configuration_name = local.name
  bucket_name                = module.databricks_bucket.id
}

resource "databricks_mws_credentials" "databricks" {
  account_id       = var.databricks_external_id
  credentials_name = local.name
  role_arn         = aws_iam_role.databricks.arn
}

resource "databricks_mws_workspaces" "databricks" {
  account_id               = var.databricks_external_id
  workspace_name           = local.name
  deployment_name          = local.name
  aws_region               = data.aws_region.current.name
  credentials_id           = databricks_mws_credentials.databricks.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.databricks.storage_configuration_id
  network_id               = databricks_mws_networks.networking.network_id
}
