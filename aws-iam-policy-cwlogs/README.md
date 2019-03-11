# AWS IAM policy  to allow cloudwatch logs

This will create a policy that allows writing to cloudwatch logs and attach it to the supplied role.

## Example

```hcl
module "policy" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-policy-cwlogs?ref=v0.14.0"


  iam_path        = "..."
  target_role     = "..."

  depends_on = [...]
}
```


<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam\_path |  | string | `"/"` | no |
| role\_name | The role to which this policy should be attached. | string | n/a | yes |

<!-- END -->
