resource "kubectl_manifest" "eso_cluster_secret_store" {
  count = var.addons.enable_external_secrets ? 1 : 0

  yaml_body = templatefile(
    "${path.module}/templates/external-secrets/cluster-secret-store.yaml.tmpl",
    {
      # all stack, env and cluster-wide secrets are stored in us-west-2 because that is the location
      # for which Argus API has a credential for. Even if clusters live in another region, they will
      # sync their stack, env and cluster-wide secrets from the us-west-2 region.
      cluster_secret_store_name : "aws-secretsmanager",
      aws_region : "us-west-2",
      service_account_name : var.addons.external_secrets_config.service_account_name,
      service_account_namespace : var.addons.external_secrets_config.namespace,
    }
  )

  force_new = true
  depends_on = [
    module.other_addons
  ]
}

resource "kubectl_manifest" "eso_cluster_secret_store_us_east_1" {
  count = var.addons.enable_external_secrets ? 1 : 0

  yaml_body = templatefile(
    "${path.module}/templates/external-secrets/cluster-secret-store.yaml.tmpl",
    {
      # Additional secret store for the clusters deployed into us-east-1 region, primarily used by AI/ML team
      cluster_secret_store_name : "aws-secretsmanager-us-east-1",
      aws_region : "us-east-1",
      service_account_name : var.addons.external_secrets_config.service_account_name,
      service_account_namespace : var.addons.external_secrets_config.namespace,
    }
  )

  force_new = true
  depends_on = [
    module.other_addons
  ]
}
