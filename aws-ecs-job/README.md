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

## Migrating old ECS services
Older ECS services were created with an ARN in an old format that did not include the ECS cluster name as part of the ARN. AWS began allowing opt-in to the new ARN format starting November 15, 2018, and will require the new format starting January 1, 2020. ECS only allows applying tags (such as cost tags) on services that have the new ARN format. Applying tags to older ECS services using the old ARN format will return the following error message:
```
InvalidParameterException: Long arn format must be used for tagging operations
```
This module by default will assume your organization has opted in to the new ARN format and will apply tags to the ECS service. Creating new services after the opt-in will work fine, but migrating an existing older ECS service to using this module (via a state mv or an import) will encounter the above error message the next time it is applied.

Since changing a service to use the new ARN requires destroying and recreating the service, this can result in downtime. In such cases, you can opt-out applying tags by passing `tag_service = false` as an argument to the module. It is recommended that at the next possible down time, the ECS service be replaced by running `terraform taint`, and if `manage_task_definition = false` restoring the ECS task definition version (the taint/replace will restore to only the last stub definition). After the service is destroy/replaced, the `tag_
service = false` argument can be removed.

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
| cluster\_id | n/a | `string` | n/a | yes |
| container\_name | Name of the container. Must match name in task definition. If omitted, defaults to name derived from project/env/service. | `string` | `null` | no |
| deployment\_maximum\_percent | (Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy. | `number` | `200` | no |
| deployment\_minimum\_healthy\_percent | (Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. | `number` | `100` | no |
| desired\_count | n/a | `number` | n/a | yes |
| env | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| manage\_task\_definition | If false, Terraform will not touch the task definition for the ECS service after initial creation | `bool` | `true` | no |
| ordered\_placement\_strategy | Placement strategy for the task instances. | `list(object({ type = string, field = string }))` | `[]` | no |
| owner | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| project | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| registry\_secretsmanager\_arn | ARN for AWS Secrets Manager secret for credentials to private registry | `string` | `null` | no |
| scheduling\_strategy | Scheduling strategy for the service: REPLICA or DAEMON. | `string` | `"REPLICA"` | no |
| service | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| tag\_service | Apply cost tags to the ECS service. Only specify false for backwards compatibility with old ECS services. | `bool` | `true` | no |
| task\_definition | JSON to describe task. If omitted, defaults to a stub task that is expected to be managed outside of Terraform. | `string` | `null` | no |
| task\_role\_arn | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecs\_service\_arn | ARN for the ECS service. |
| ecs\_task\_definition\_family | The family of the task definition defined for the given/generated container definition. |

<!-- END -->
