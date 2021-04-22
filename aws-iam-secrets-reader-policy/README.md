# AWS IAM policy to read from secrets manager

Grant read permissions on listed secrets to this role.

## Example

```hcl
module "policy" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-secrets-reader-policy?ref=v0.36.0"

  iam_path  = "..."
  role_name = "..."

  secrets_arns = [...]
}
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | < 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | n/a | `string` | `"/"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The role to which this policy should be attached. | `string` | n/a | yes |
| <a name="input_secrets_arns"></a> [secrets\_arns](#input\_secrets\_arns) | List of secrets ARNs for reading. | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END -->
