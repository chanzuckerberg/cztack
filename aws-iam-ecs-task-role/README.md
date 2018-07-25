# AWs IAM Role for ECS Tasks

This will create a role for attaching to an ECS task, using `var.policy`.
<!-- START -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| env | Computing environment, for example dev, staging or prod. | string | - | yes |
| owner | Email address of the owner. Can be a group. | string | - | yes |
| policy | IAM policy to grant to this role. | string | - | yes |
| project | High-level project, should be unique across CZI | string | - | yes |
| service | Name of this thing we're running.  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |

<!-- END -->
