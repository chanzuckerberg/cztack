output "repository_name" {
  value = aws_ecr_repository.repo.name
}

output "repository_url" {
  value = aws_ecr_repository.repo.repository_url
}

output "repository_arn" {
  value = aws_ecr_repository.repo.arn
}
