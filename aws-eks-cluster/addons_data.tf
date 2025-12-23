module "eks_data_addons" {
  source  = "aws-ia/eks-data-addons/aws"
  version = "1.31.5"

  oidc_provider_arn = module.cluster.oidc_provider_arn

  enable_kubecost = var.addons_data.enable_kubecost

  enable_jupyterhub = var.addons_data.enable_jupyterhub
  jupyterhub_helm_config = {
    values = [
      templatefile(
        "${path.module}/templates/jupyterhub/jupyterhub-values.yaml",
        var.addons_data.jupyterhub_helm_config
      )
    ]
    version = "3.3.7"
  }
}
