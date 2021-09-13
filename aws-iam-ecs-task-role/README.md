# AWs IAM Role for ECS Tasks

This will create a role for attaching to an ECS task, using `policy`.

## Example

```hcl
module "ecs-role" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-ecs-task-role?ref=v0.14.0"

  # Variables used for tagging.
  project = "..."
  env     = "..."
  service = "..."
  owner   = "..."
}

output "ecs-role-arn" {
  value = "${module.ecs-role.arn}"
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
| env | Environment name. For example– dev, staging or prod. | `string` | n/a | yes |
| iam\_path | IAM path for the role. | `string` | `"/"` | no |
| owner | Email address of the owner. Can be a group address. | `string` | n/a | yes |
| project | High-level project, should be unique across the organization. | `string` | n/a | yes |
| service | Name of this thing we're running. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| name | n/a |

<!-- END -->
