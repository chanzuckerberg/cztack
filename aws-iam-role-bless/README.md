# Module template

## Example

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/...?ref=v0.12.0"
}

output "..." {
  value = "${...}"
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
| role_name |  |

<!-- END -->
