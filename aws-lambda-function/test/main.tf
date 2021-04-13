resource "random_string" "random" {
  length  = 6
  special = false
}


data "archive_file" "notifier" {
  type        = "zip"
  source_file = "${path.module}/hello.py"
  output_path = "${path.module}/hello.zip"
}

variable "project" {
  type        = string
  description = "Project for tagging and naming."
}
variable "env" {
  type        = string
  description = "Env for tagging and naming."
}
variable "service" {
  type        = string
  description = "Service for tagging and naming"
}
variable "owner" {
  type        = string
  description = "Owner for tagging and naming."
}

module "lambda" {
  source = "../."

  handler = "hello.hello"
  runtime = "python3.8"

  filename         = data.archive_file.notifier.output_path
  source_code_hash = data.archive_file.notifier.output_base64sha256

  log_retention_in_days = 1

  project = var.project
  env     = var.env
  service = var.service
  owner   = var.owner
}

output "arn" {
  value = module.lambda.arn
}

output "invoke_arn" {
  value = module.lambda.invoke_arn
}

output "log_group_name" {
  value = module.lambda.log_group_name
}
