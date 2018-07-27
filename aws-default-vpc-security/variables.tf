variable "default_sg_lockdown" {
  default     = true
  description = "Restrict default security group to deny all traffic (you can selectively enable traffic with other security groups)."
}

# TODO
# variable "vpc_flow_logs_group_name" {
#   description = "The CloudWatch Logs group to which VPC Flow Logs will be written."
# }
# variable "vpc_flow_logs_iam_role_arn" {
#   description = "IAM Role ARN which will be used by VPC Flow Logs."
# }

