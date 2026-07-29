# AWS IAM Role GitHub Action
This module creates a role that is assumable from a github action via OIDC federation. We therefore do not need to add static AWS credentials to the GitHub action.

You must specify which of our repos are authorized to assume this role. As always, be mindful of least privilege and such.

AWS provides an [official GitHub action](https://github.com/aws-actions/configure-aws-credentials) that facilitates working with this paradigm.

You can use it in your GitHub actions as follows:
```
    - name: Configure AWS Credentials
      uses: aws-actions/configure-aws-credentials@v1
      with:
        role-to-assume: arn:aws:iam::123456789100:role/my-github-actions-role
        aws-region: us-west-2
```

Where `role-to-assume` is the ARN of the role this module creates.

NOTE: this module doesn't manage the role's permissions. Users of this module should handle these separately with an eye towards CI/CD least privilege.

## OIDC subject claim formats

GitHub issues the token's `sub` claim in one of two formats:

| Format | Example |
|------|---------|
| Legacy (name only) | `repo:octo-org/octo-repo:ref:refs/heads/main` |
| [Immutable](https://docs.github.com/en/actions/reference/security/oidc#immutable-subject-claims) (name plus IDs) | `repo:octo-org@123456/octo-repo@456789:ref:refs/heads/main` |

Repos created, renamed, or transferred after 2026-07-15 use the immutable format, as do repos that opt in through the org or repo OIDC settings. Everything else keeps the legacy format. The two are not interchangeable — the immutable format inserts `@OWNER-ID` ahead of the `/`, so a trust policy written for one format rejects the other.

This module's trust policy accepts both, so a repo switching formats keeps its access without a Terraform change. You still authorize repos by name; the owner and repo IDs are wildcarded.


<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.45 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_assume_role_policies_json"></a> [additional\_assume\_role\_policies\_json](#input\_additional\_assume\_role\_policies\_json) | The JSON string of any other additional assume role policies to add to the Github Actions role | `string` | `""` | no |
| <a name="input_authorized_aws_accounts"></a> [authorized\_aws\_accounts](#input\_authorized\_aws\_accounts) | The map of authorized AWS accounts to assume the created role. | `map(string)` | `{}` | no |
| <a name="input_authorized_github_repos"></a> [authorized\_github\_repos](#input\_authorized\_github\_repos) | A map that specifies the authorized repos to assume the created role.<br>  Keys specify the name of the GitHub org.<br>  Values specify the authorized repos within that org. | `map(list(string))` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | Configure the AWS IAM Role. | <pre>object({<br>    name : string,<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Standard tagging. | <pre>object({<br>    env : string,<br>    owner : string,<br>    managedBy : string,<br>    project : string<br>    service : string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role"></a> [role](#output\_role) | n/a |
<!-- END -->
