# AWS IAM Instance Profile

This module will create an EC2 instance profile, attaching to it a new IAM role with permissions to run standard system agents (Systems Manager Agent and Cloudwatch Logs Agent).

The IAM role has policies attached to allow it to integrate with AWS reporting agents to track systems configuration and for remote maintenance through Systems Manager. It also allows reporting logs of the agents through Cloudwatch Logs Agent.

For any other permissions that need to be attached to the role, this can be done by using the role name/ARN returned as an output.

## Example

```hcl
module "profile" {
  source = "github.com/chanzuckerberg/cztack//aws-iam-instance_profile?ref=v0.14.0"

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| iam_path | The IAM path to the role. | string | `/` | no |
| name_prefix | Creates a unique name for both the role and instance profile beginning with the specified prefix. Max 32 characters long. | string | - | yes |
| role_description | The description of the IAM role. | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| profile_arn | The ARN assigned by AWS to the instance profile. |
| profile_name | The instance profile's name. |
| role_arn | The Amazon Resource Name (ARN) specifying the role. |
| role_name | The name of the role. |

<!-- END -->
