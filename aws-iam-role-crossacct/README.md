# Module template

## Example

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/...?ref=v0.11.0"
}

output "..." {
  value = "${...}"
}
```

<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path | The IAM path to put this role in. | string | `/` | no |
| role_name | The name of the role. | string | - | yes |
| source_account_id | The AWS account id that should be able to assume this role. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam_path |  |
| role_name |  |

<!-- END -->
