# AWs IAM Role for ECS Tasks

This will create a role for attaching to an ECS task, using `policy`.

## Example

```hcl
module "ecs-role" {
  source = "github.com/chanzuckerberg/cztack/aws-iam-ecs-task-role?ref=master" # FIXME
  
  policy = "..."

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| env | Environment name. For example– dev, staging or prod. | string | - | yes |
| owner | Email address of the owner. Can be a group address. | string | - | yes |
| policy | IAM policy to grant to this role. | string | - | yes |
| project | High-level project, should be unique across the organization. | string | - | yes |
| service | Name of this thing we're running. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |

<!-- END -->
