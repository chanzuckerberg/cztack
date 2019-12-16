output "role_arn" {
  value       =  aws_iam_role.role.arn
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "role_name" {
  value       =  aws_iam_role.role.name
  description = "The name of the role."
}

output "profile_arn" {
  value       =  aws_iam_instance_profile.profile.arn
  description = "The ARN assigned by AWS to the instance profile."
}

output "profile_name" {
  value       =  aws_iam_instance_profile.profile.name
  description = "The instance profile's name."
}
