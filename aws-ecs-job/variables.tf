variable "project" {
  type        = string
  description = "Project for tagging and naming. See [doc](../README.md#consistent-tagging)"
}

variable "service" {
  type        = string
  description = "Service for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "env" {
  type        = string
  description = "Env for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "owner" {
  type        = string
  description = "Owner for tagging and naming. See [doc](../README.md#consistent-tagging)."
}

variable "cluster_id" {
  type = string
}

variable "desired_count" {
  type = number
}

variable "deployment_maximum_percent" {
  description = "(Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy."
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "(Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  type        = number
  default     = 100
}

variable "task_role_arn" {
  type = string
}

variable "task_definition" {
  description = "JSON to describe task. If omitted, defaults to a stub task that is expected to be managed outside of Terraform."
  type        = string
  default     = null
}

variable "scheduling_strategy" {
  description = "Scheduling strategy for the service: REPLICA or DAEMON."
  default     = "REPLICA"
}

variable "container_name" {
  description = "Name of the container. Must match name in task definition. If omitted, defaults to name derived from project/env/service."
  type        = string
  default     = null
}

variable "manage_task_definition" {
  description = "If false, Terraform will not touch the task definition for the ECS service after initial creation"
  type        = bool
  default     = true
}