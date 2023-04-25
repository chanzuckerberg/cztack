data "aws_caller_identity" "current" {}

locals {
  idp     = "token.actions.githubusercontent.com"
  idp_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.idp}"
}

// https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services#adding-the-identity-provider-to-aws
data "aws_iam_policy_document" "assume_role" {
  dynamic "statement" {
    for_each = var.authorized_github_repos

    content {
      principals {
        type        = "Federated"
        identifiers = [local.idp_arn]
      }

      actions = ["sts:AssumeRoleWithWebIdentity", "sts:TagSession"]
      condition {
        test     = "StringLike"
        variable = "${local.idp}:sub"
        values = formatlist(
          "repo:%s/%s:*",
          statement.key,
          statement.value,
        )
      }
    }
  }
}

resource "aws_iam_role" "role" {
  name = var.role.name

  tags = var.tags

  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  max_session_duration = 60 * 60 // 1 hour, not sure what max github action exec time is

  # We have to force detach policies in order to recreate roles.
  # The other option would be to use name_prefix and create_before_destroy, but that
  # doesn't work if you want a role with a stable, memorable name.
  force_detach_policies = true
}
