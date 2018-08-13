# AWS IAM policy  to allow cloudwatch logs

This will create a policy that allows writing to cloudwatch logs and attach it to the supplied role.

## Example

```hcl
module "policy" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-policy-cwlogs?ref=v0.11.0"


  iam_path        = "..."
  target_role     = "..."

  depends_on = [...]
}
```


<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path |  | string | `/` | no |
| role_name | The role to which this policy should be attached. | string | - | yes |

<!-- END -->
