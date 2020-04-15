# AWS IAM Instance Profile

This module will create an EC2 instance profile, attaching to it a new IAM role with permissions to run standard system agents (Systems Manager Agent and Cloudwatch Logs Agent).

The IAM role has policies attached to allow it to integrate with AWS reporting agents to track systems configuration and for remote maintenance through Systems Manager. It also allows reporting logs of the agents through Cloudwatch Logs Agent.

For any other permissions that need to be attached to the role, this can be done by using the role name/ARN returned as an output.

## Example

```hcl
module "profile" {
  source = "github.com/chanzuckerberg/cztack//aws-iam-instance-profile?ref=v0.15.1"

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
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_role | Creates a role for use with the instance profile. | `bool` | `true` | no |
| existing\_role\_name | Use existing role with the given name instead of creating a new role. Attaches all standard policies to given role. Only used if create\_role is false. | `string` | `null` | no |
| iam\_path | The IAM path to the role. | `string` | `"/"` | no |
| name\_prefix | Creates a unique name for both the role and instance profile beginning with the specified prefix. Max 32 characters long. | `string` | n/a | yes |
| role\_description | The description of the IAM role. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| profile\_arn | The ARN assigned by AWS to the instance profile. |
| profile\_name | The instance profile's name. |
| role\_arn | The Amazon Resource Name (ARN) specifying the role. |
| role\_name | The name of the role. |

<!-- END -->
