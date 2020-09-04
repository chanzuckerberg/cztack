# ECS Job on Fargate

This creates an ECS service running on Fargate with no load balancer in front of it. Good for
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

Since changing a service to use the new ARN requires destroying and recreating the service, this can result in downtime. In such cases, you can opt-out applying tags by passing `tag_service = false` as an argument to the module. It is recommended that at the next possible down time, the ECS service be replaced by running `terraform taint`, and if `manage_task_definition = false` restoring the ECS task definition version (the taint/replace will restore to only the last stub definition). After the service is destroy/replaced, the `tag_service = false` argument can be removed.

<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.job](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_service.unmanaged-job](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.job](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.task_execution_role_secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.registry_secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | n/a | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Name of the container. Must match name in task definition. If omitted, defaults to name derived from project/env/service. | `string` | `null` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU units for Fargate task. Used if task\_definition provided, or for initial stub task if externally managed. | `number` | `256` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | (Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy. | `number` | `200` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | (Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. | `number` | `100` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | n/a | `number` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_manage_task_definition"></a> [manage\_task\_definition](#input\_manage\_task\_definition) | If false, Terraform will not touch the task definition for the ECS service after initial creation | `bool` | `true` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory in megabytes for Fargate task. Used if task\_definition provided, or for initial stub task if externally managed. | `number` | `512` | no |
| <a name="input_ordered_placement_strategy"></a> [ordered\_placement\_strategy](#input\_ordered\_placement\_strategy) | Placement strategy for the task instances. | `list(object({ type = string, field = string }))` | `[]` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_registry_secretsmanager_arn"></a> [registry\_secretsmanager\_arn](#input\_registry\_secretsmanager\_arn) | ARN for AWS Secrets Manager secret for credentials to private registry | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group to use for the Fargate task. | `list(string)` | `[]` | no |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_tag_service"></a> [tag\_service](#input\_tag\_service) | Apply cost tags to the ECS service. Only specify false for backwards compatibility with old ECS services. | `bool` | `true` | no |
| <a name="input_task_definition"></a> [task\_definition](#input\_task\_definition) | JSON to describe task. If omitted, defaults to a stub task that is expected to be managed outside of Terraform. | `string` | `null` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_task_subnets"></a> [task\_subnets](#input\_task\_subnets) | Subnets to launch Fargate task in. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_service_arn"></a> [ecs\_service\_arn](#output\_ecs\_service\_arn) | ARN for the ECS service. |
| <a name="output_ecs_task_definition_family"></a> [ecs\_task\_definition\_family](#output\_ecs\_task\_definition\_family) | The family of the task definition defined for the given/generated container definition. |
| <a name="output_task_execution_role_arn"></a> [task\_execution\_role\_arn](#output\_task\_execution\_role\_arn) | Task execution role for Fargate task. |
<!-- END -->
