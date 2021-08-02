module "role" {
  source             = "../aws-iam-role-crossacct"
  role_name          = var.role_name
  iam_path           = var.iam_path
  source_account_ids = var.source_account_ids
  saml_idp_arns      = var.saml_idp_arns
  oidc               = var.oidc

  project = var.project
  env     = var.env
  service = var.service
  owner   = var.owner
}

resource "aws_iam_role_policy_attachment" "readonly" {
  count      = var.readonly ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "all" {
  count      = var.all ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# IAM
resource "aws_iam_role_policy_attachment" "iam" {
  count      = var.iam ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

# Route53
resource "aws_iam_role_policy_attachment" "route53" {
  count      = var.route53 ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

# KMS
resource "aws_iam_role_policy_attachment" "kms" {
  count      = var.kms ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser"
}

# ACM
resource "aws_iam_role_policy_attachment" "acm" {
  count      = var.acm ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess"
}

# Cloudwatch
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  count      = var.cloudwatch ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

# Config
# TODO

# ECR
resource "aws_iam_role_policy_attachment" "ecr" {
  count      = var.ecr ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

# Guardduty
resource "aws_iam_role_policy_attachment" "guardduty" {
  count      = var.guardduty ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonGuardDutyFullAccess"
}

# Kinesis
resource "aws_iam_role_policy_attachment" "kinesis" {
  count      = var.kinesis ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess"
}

# Lambda
resource "aws_iam_role_policy_attachment" "lambda" {
  count      = var.lambda ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
}

# S3
resource "aws_iam_role_policy_attachment" "s3" {
  count      = var.route53 ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# secretsmanager
resource "aws_iam_role_policy_attachment" "secretsmanager" {
  count      = var.secretsmanager ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

# securityhub
resource "aws_iam_role_policy_attachment" "securityhub" {
  count      = var.securityhub ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AWSSecurityHubFullAccess"
}

# ssm
resource "aws_iam_role_policy_attachment" "ssm" {
  count      = var.ssm ? 1 : 0
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

# below is copied & modified from https://raw.githubusercontent.com/chanzuckerberg/cztack/master/aws-iam-role-infraci/main.tf
# because it is not available as a module on its own

data "aws_iam_policy_document" "secrets" {
  statement {
    sid = "ssm"

    actions = [
      "ssm:DescribeParameters",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]

    resources = ["*"]
  }

  statement {
    sid       = "kms"
    actions   = ["kms:Decrypt"]
    resources = ["*"]
  }

  statement {
    sid = "servicediscovery"

    actions = [
      "servicediscovery:GetService",
      "servicediscovery:GetNamespace",
    ]

    resources = ["*"]
  }

  statement {
    sid       = "secretsmanager"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "secretsmanager:ResourceTag/allowCI"
      values   = ["true"]
    }
  }
}

resource "aws_iam_policy" "secrets" {
  name   = "${var.role_name}-secrets-reader"
  path   = var.iam_path
  policy = data.aws_iam_policy_document.secrets.json

  lifecycle {
    ignore_changes = [name]
  }
}

resource "aws_iam_role_policy_attachment" "secrets" {
  role       = module.role.role_name
  policy_arn = aws_iam_policy.secrets.arn
}
