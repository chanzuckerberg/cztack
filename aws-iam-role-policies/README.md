# AWS-IAM-ROLE-POLICIES
A module for creating an IAM role with the inline policies and managed policies attached to the role.

## Example

```hcl
module iam-role {
  source = "github.com/chanzuckerberg/cztack//aws-iam-role-policies?ref=..."

  principals = [
    {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  ]

  role_name              = "..."
  role_description       = "...."
  attached_policies_arns = [aws_iam_policy.policy.arn]

  owner   = var.owner
  project = var.project
  service = var.component
  env     = var.env
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| role\_name | IAM role name. | `string` | n/a | yes |
| role\_description | IAM role description. | `string` | null | no |
| inline\_policies | List of inline policies to be associated with the IAM role. | `list(object({ name = string, policy = string }))`  | `[]` | no |
| attached\_policies\_arns | List of policies ARNs to be attached to the IAM role. | `list(string)` | `[]` | no |
| principals | The Principal element in the role's trust policy to specify who can assume the role, this will be used in the `assume_role_policy` for the IAM role. More in [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html) | `list(object({ type = string, identifiers = list(string) }))`  | `[]` | no |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| role_name | IAM role name. |
| role_arn  | IAM role ARN |

<!-- START -->

<!-- END -->
