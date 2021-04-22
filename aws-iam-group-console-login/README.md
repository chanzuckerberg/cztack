# AWS IAM group for console login

This module will create an IAM group and grant access for its members to log into the AWS console and manage their own credentials (and nothing more).

## Example 

```hcl
module "group" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-group-console-login?ref=v0.14.0"

  group_name = "..."
  iam_path   = "..."
}

output "group_name" {
  value = "${module.group.group_name}"
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
| [aws_iam_group.login](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.self-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.self-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.self-iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | Name of the group to be created. | `string` | `"console-login"` | no |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | IAM path under which resources will be created. | `string` | `"/"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | n/a |
<!-- END -->
