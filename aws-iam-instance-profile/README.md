# AWS IAM Instance Profile

This module will create an EC2 instance profile, attaching to it a new IAM role with permissions to run standard system agents (Systems Manager Agent and Cloudwatch Logs Agent).

The IAM role has policies attached to allow it to integrate with AWS reporting agents to track systems configuration and for remote maintenance through Systems Manager. It also allows reporting logs of the agents through Cloudwatch Logs Agent.

For any other permissions that need to be attached to the role, this can be done by using the role name/ARN returned as an output.

## Example

```hcl
module "profile" {
  source = "github.com/chanzuckerberg/cztack//aws-iam-instance-profile?ref=v0.36.0"

  # The prefix of the name of the instance profile and role to create in this account.
  name_prefix = "..."
}

resource "aws_iam_role_policy_attachment" {
  role       = "${module.profile.role_arn}"
  policy_arn = "arn:aws:iam::aws:policy/AnyPolicyARNGoesHere"
}

resource "aws_instance" "instance" {
  # ...
  iam_instance_profile = "${module.profile.profile_arn}"
  # ...
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
| [aws_iam_instance_profile.profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloudwatch-agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm-agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Creates a role for use with the instance profile. | `bool` | `true` | no |
| <a name="input_existing_role_name"></a> [existing\_role\_name](#input\_existing\_role\_name) | Use existing role with the given name instead of creating a new role. Attaches all standard policies to given role. Only used if create\_role is false. | `string` | `null` | no |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | The IAM path to the role. | `string` | `"/"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Creates a unique name for both the role and instance profile beginning with the specified prefix. Max 32 characters long. | `string` | n/a | yes |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | The description of the IAM role. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_profile_arn"></a> [profile\_arn](#output\_profile\_arn) | The ARN assigned by AWS to the instance profile. |
| <a name="output_profile_name"></a> [profile\_name](#output\_profile\_name) | The instance profile's name. |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The Amazon Resource Name (ARN) specifying the role. |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The name of the role. |
<!-- END -->
