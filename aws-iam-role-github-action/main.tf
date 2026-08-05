data "aws_caller_identity" "current" {}

locals {
  idp     = "token.actions.githubusercontent.com"
  idp_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.idp}"

  authorized_repos = {
    for pair in flatten([
      for org, repos in var.authorized_github_repos : [
        for repo in repos : { org = org, repo = repo }
      ]
    ]) : "${pair.org}/${pair.repo}" => pair
  }

  condition_repo_keys = flatten([
    for org, repos in var.authorized_github_repo_conditions : [
      for repo in keys(repos) : "${org}/${repo}"
    ]
  ])

  unmatched_condition_keys = [
    for key in local.condition_repo_keys : key
    if !contains(keys(local.authorized_repos), key)
  ]

  statement_sids = [
    for pair in values(local.authorized_repos) :
    replace("Allow${pair.org}${pair.repo}ToAssumeRole", "/[^0-9A-Za-z]/", "")
  ]
}

// https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services#adding-the-identity-provider-to-aws
data "aws_iam_policy_document" "assume_role" {
  dynamic "statement" {
    for_each = var.authorized_aws_accounts

    content {
      sid = "AllowAssumeRoleFrom${statement.key}"
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${statement.value}:root"]
      }
      actions = ["sts:AssumeRole", "sts:TagSession"]
      effect  = "Allow"
    }
  }
  dynamic "statement" {
    for_each = local.authorized_repos

    content {
      sid = replace("Allow${statement.value.org}${statement.value.repo}ToAssumeRole", "/[^0-9A-Za-z]/", "")
      principals {
        type        = "Federated"
        identifiers = [local.idp_arn]
      }

      actions = ["sts:AssumeRoleWithWebIdentity", "sts:TagSession"]
      condition {
        test     = "StringLike"
        variable = "${local.idp}:sub"

        // GitHub mints subject claims in two shapes and they are not
        // interchangeable: the immutable format inserts @OWNER-ID ahead of the "/",
        // so a legacy pattern can never match an immutable subject. Match both, or a
        // repo that switches formats loses access. Repos created, renamed, or
        // transferred after 2026-07-15 use the immutable format; older repos keep
        // the legacy one until they opt in.
        // https://docs.github.com/en/actions/reference/security/oidc#immutable-subject-claims
        //
        // The owner and repo IDs are wildcarded since callers authorize repos by
        // name, which keeps this module's trust model unchanged across the switch.
        // Neither pattern matches the other's format, so listing both grants no
        // access beyond the named org and repos.
        values = [
          "repo:${statement.value.org}/${statement.value.repo}:*",
          "repo:${statement.value.org}@*/${statement.value.repo}@*:*",
        ]
      }

      dynamic "condition" {
        for_each = try(var.authorized_github_repo_conditions[statement.value.org][statement.value.repo], [])

        content {
          test     = condition.value.test
          variable = "${local.idp}:${condition.value.claim}"
          values   = condition.value.values
        }
      }
    }
  }
}

data "aws_iam_policy_document" "this" {
  source_policy_documents = compact([
    data.aws_iam_policy_document.assume_role.json,
    var.additional_assume_role_policies_json,
  ])
}

resource "aws_iam_role" "role" {
  name = var.role.name

  tags = var.tags

  assume_role_policy   = data.aws_iam_policy_document.this.json
  max_session_duration = 60 * 60 // 1 hour, not sure what max github action exec time is

  # We have to force detach policies in order to recreate roles.
  # The other option would be to use name_prefix and create_before_destroy, but that
  # doesn't work if you want a role with a stable, memorable name.
  force_detach_policies = true

  lifecycle {
    precondition {
      condition     = length(local.unmatched_condition_keys) == 0
      error_message = "authorized_github_repo_conditions references org/repo pairs missing from authorized_github_repos: ${join(", ", local.unmatched_condition_keys)}"
    }

    precondition {
      condition     = length(local.statement_sids) == length(distinct(local.statement_sids))
      error_message = "authorized_github_repos produces colliding trust statement sids after stripping non-alphanumeric characters. Rename the offending repos or split them across roles."
    }
  }
}
