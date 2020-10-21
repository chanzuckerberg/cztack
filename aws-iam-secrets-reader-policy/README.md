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
| aws | < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| iam\_path | n/a | `string` | `"/"` | no |
| role\_name | The role to which this policy should be attached. | `string` | n/a | yes |
| secrets\_arns | List of secrets ARNs for reading. | `list(string)` | n/a | yes |

## Outputs

No output.

<!-- END -->
