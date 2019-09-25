# ECS Job

This creates an ECS service with no load balancer in front of it. Good for
background worker daemon sort of things.

## Terraform managed task definition vs czecs

If the user sets `var.manage_task_definition = true`, Terraform will manage the lifecycle
of the container definition; any external changes are reset on the next Terraform run.

If var.manage_task_definition = false, the user is expected to manage the
container definition external to Terraform (e.g. using [czecs](https://github.com/chanzuckerberg/czecs)). Upon creation,
Terraform will use a stub definition, but from that point forward will ignore any
changes to the definition, allowing external task definition management.

<!-- START -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_id |  | string | n/a | yes |
| container\_name | Name of the container. Must match name in task definition. If omitted, defaults to name derived from project/env/service. | string | `null` | no |
| deployment\_maximum\_percent | (Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy. | number | `200` | no |
| deployment\_minimum\_healthy\_percent | (Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. | number | `100` | no |
| desired\_count |  | number | n/a | yes |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | string | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | string | n/a | yes |
| scheduling\_strategy | Scheduling strategy for the service: REPLICA or DAEMON. | string | `"REPLICA"` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | string | n/a | yes |
| task\_definition | JSON to describe task. If omitted, defaults to a stub task that is expected to be managed outside of Terraform. | string | `null` | no |
| task\_role\_arn |  | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecs\_service\_arn | ARN for the ECS service. |
| ecs\_task\_definition\_family | The family of the task definition defined for the given/generated container definition. |

<!-- END -->
