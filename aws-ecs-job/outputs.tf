output "ecs_service_arn" {
  description = "ARN for the ECS service."

  # Awful hack modified from https://github.com/hashicorp/terraform/issues/16726
  # Since we know exactly one of the following has count > 0, we just concatenate all the mostly empty lists, and return the first element.
  value = concat(aws_ecs_service.unmanaged-job.*.id, aws_ecs_service.job.*.id)[0]
}

output "ecs_task_definition_family" {
  description = "The family of the task definition defined for the given/generated container definition."
  value       = aws_ecs_task_definition.job.family
}
