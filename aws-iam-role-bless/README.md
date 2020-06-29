# AWS IAM Role - Bless client

Creates a role for use with [blessclients](https://github.com/lyft/python-blessclient).

## Example

```hcl
module "aws-iam-role-bless" {
  source = "github.com/chanzuckerberg/cztack//aws-iam-role-bless?ref=v0.14.0"

  role_name = "..."
  source_account_id = "..."
  bless_lambda_arns = "..."
}

output "..." {
  role_name = "${module.aws-iam-role-bless.role_name}"
  role_arn = "${module.aws-iam-role-bless.role_arn}"
}
```

<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bless\_lambda\_arns | List of bless lambda arns | `list` | n/a | yes |
| iam\_path | IAM path | `string` | `"/"` | no |
| role\_name | The name for the role | `string` | n/a | yes |
| source\_account\_id | The source aws account id to allow sts:AssumeRole. DEPRECATED: Please use source\_account\_ids | `string` | n/a | yes |
| source\_account\_ids | The source aws account ids to allow sts:AssumeRole | `set(string)` | `[]` | no |
| tags | A map of tags to assign this IAM Role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_name | n/a |

<!-- END -->
