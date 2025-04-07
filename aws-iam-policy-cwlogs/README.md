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
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.17.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.logs-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.attach-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_document.logs-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | n/a | `string` | `"/"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The role to which this policy should be attached. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END -->
