// HACK(el): we do this to hint TF dependency graph since modules can't depend_on
output "id" {
  value = aws_efs_file_system.efs.id
}

output "dns_name" {
  value = aws_efs_mount_target.efs[0].dns_name
}

output "security_group" {
  value = aws_security_group.efs.id
}
