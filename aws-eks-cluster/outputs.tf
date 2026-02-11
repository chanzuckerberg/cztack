output "cluster_id" {
  description = "The name of the EKS cluster."
  value       = module.cluster.cluster_name
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster."
  value       = module.cluster.cluster_arn
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = module.cluster.cluster_endpoint
}

output "cluster_ca" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = module.cluster.cluster_certificate_authority_data
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.cluster.cluster_oidc_issuer_url
}

output "cluster_primary_security_group_id" {
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
  value       = module.cluster.cluster_primary_security_group_id
}

output "cluster_security_group" {
  description = "Security group ID attached to the EKS workers."
  value       = aws_security_group.cluster.id
}

output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster."
  value       = module.cluster.cluster_iam_role_name
}

output "cluster_version" {
  description = "EKS cluster version"
  value       = module.cluster.cluster_version
}

output "worker_iam_role_name" {
  description = "IAM role name attached to EKS workers"
  value       = aws_iam_role.node.name
}

output "worker_security_group" {
  description = "Security group ID attached to the EKS workers."
  value       = aws_security_group.node.id
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if enable_irsa = true."
  value       = module.cluster.oidc_provider_arn
}

output "secrets_key_arn" {
  description = "The ARN of the KMS Key used to encrypt cluster secrets."
  value       = coalescelist(aws_kms_key.secrets[*].arn, [null])[0]
}

output "gh_action_role" {
  description = "The roles created for GitHub Actions to interact with this cluster."
  value       = one(module.gh_actions_role[*].role)
}

output "cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with the EKS cluster."
  value       = module.cluster.cluster_certificate_authority_data
}

output "s3_csi_role_arn" {
  description = "The ARN of the IAM role for the S3 CSI driver."
  value       = aws_iam_role.s3_csi.arn
}

output "s3_csi_role_name" {
  description = "The name of the IAM role for the S3 CSI driver."
  value       = aws_iam_role.s3_csi.name
}

output "argocd_root_role_name" {
  description = "Name of the ArgoCD service account IAM role"
  value       = var.addons.enable_argocd ? aws_iam_role.argocd_sa_role[0].name : null
}

output "argocd_root_role_arn" {
  description = "ARN of the ArgoCD service account IAM role"
  value       = var.addons.enable_argocd ? aws_iam_role.argocd_sa_role[0].arn : null
}
