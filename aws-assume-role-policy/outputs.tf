output "json" {
  value       = data.aws_iam_policy_document.assume-role.json
  description = "JSON version of assume-role policy"
}
