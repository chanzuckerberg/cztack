locals {
  namespace = replace("${var.tags.project}_${var.tags.env}_${var.tags.service}", "-", "_")
  role_name = "gh_actions_${local.namespace}"
}

module "gh_actions_role" {
  count  = length(var.authorized_github_repos) + length(var.authorized_aws_accounts) == 0 ? 0 : 1
  source = "git@github.com:chanzuckerberg/cztack//aws-iam-role-github-action?ref=v0.69.3"

  role = {
    name = local.role_name
  }
  authorized_github_repos = var.authorized_github_repos
  authorized_aws_accounts = var.authorized_aws_accounts
  tags                    = var.tags
}

data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "list_describe_cluster" {
  statement {
    actions = [
      "eks:DescribeCluster",
      "eks:ListClusters",
    ]
    resources = [
      "arn:aws:eks:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/${local.cluster_name}",
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role_policy" "list_describe_cluster" {
  for_each    = toset([for k in module.gh_actions_role : k.role.name])
  role        = each.value
  name_prefix = "list_describe_cluster"
  policy      = data.aws_iam_policy_document.list_describe_cluster.json
}


data "aws_iam_policy_document" "pull_through_cache" {
  statement {
    sid = "PullThroughCacheCorePlatformProdECR"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:BatchImportUpstreamImage",
      "ecr:CreateRepository",
      "ecr:DescribeImageScanFindings",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:ListTagsForResource",
      "ecr:TagResource",
      "ecr:PutLifecyclePolicy",
      "ecr:SetRepositoryPolicy",
    ]

    resources = ["arn:aws:ecr:us-west-2:533267185808:repository/*"]
  }
}

resource "aws_iam_role_policy" "pull_through_cache" {
  for_each    = toset([for k in module.gh_actions_role : k.role.name])
  role        = each.value
  name_prefix = "read_only_pull_through_cache_core_platform_prod_access"
  policy      = data.aws_iam_policy_document.pull_through_cache.json
}

data "aws_iam_policy_document" "ecr_scanner" {
  statement {
    sid = "ScanECR"

    actions = [
      "ecr:BatchGetRepositoryScanningConfiguration",
      "ecr:GetRegistryScanningConfiguration",
      "ecr:DescribeImageScanFindings",
      "ecr:StartImageScan",
      "ecr:PutImageScanningConfiguration",
      "ecr:PutRegistryScanningConfiguration",
      "ecr:PutImageTagMutability"
    ]

    resources = [
      "arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/*",
      "arn:aws:ecr:us-west-2:533267185808:repository/*"
    ]
  }
}

resource "aws_iam_role_policy" "ecr_scanner" {
  for_each    = toset([for k in module.gh_actions_role : k.role.name])
  role        = each.value
  name_prefix = "gh_actions_ecr_scan"
  policy      = data.aws_iam_policy_document.ecr_scanner.json
}

module "autocreated_ecr_writer_policy" {
  source   = "../aws-iam-policy-ecr-writer"
  for_each = toset([for k in module.gh_actions_role : k.role.name])

  role_name = each.value
  ecr_repository_arns = [
    "arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/*",
    "arn:aws:ecr:us-west-2:533267185808:repository/*"
  ]
  policy_name = "gh_actions_ecr_push"
  tags        = var.tags
}
