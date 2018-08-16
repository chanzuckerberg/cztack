# aws-iam-role-bless

Creates a role for use with blessclients.

## Example

```hcl
module "aws-iam-role-bless" {
  source = "github.com/chanzuckerberg/cztack/...?ref=v0.12.0"

  role_name = "..."
  source_aws_account_id = "..."
  bless_lambda_arns = "..."
}

output "..." {
  role_name = "${module.aws-iam-role-bless.role_name}"
  role_arn = "${module.aws-iam-role-bless.role_arn}"
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_iam_path | IAM path | string | `/` | no |
| bless_lambda_arns | List of bless lambda arns | list | - | yes |
| role_name | The name for the role | string | - | yes |
| source_aws_account_id | The source aws account id to allow sts:AssumeRole | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| role_arn |  |
| role_name |  |

<!-- END -->
