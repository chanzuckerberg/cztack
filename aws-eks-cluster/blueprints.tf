locals {
  karpenter_discovery             = { "karpenter.sh/discovery" = local.cluster_name }
  karpenter_discovery_per_cluster = { "karpenter.sh/discovery/${local.cluster_name}" = local.cluster_name }
  fluentbit_log_group_name        = "/aws/eks/${local.cluster_name}/aws-fluentbit-logs"
  default_exclude_list = [
    "/var/log/containers/aws-for-fluent-bit*",
    "/var/log/containers/aws-node*",
    "/var/log/containers/kube-proxy*",
    "/var/log/containers/scraper-collector*"
  ]
  exclude_list = distinct(concat(local.default_exclude_list, var.addons.fluentbit_exclude_paths))
}

data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.us-east-1
}

data "aws_iam_policy_document" "fluentbit_policy" {
  statement {
    sid       = "FluentbitCWLogs"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutRetentionPolicy",
      "logs:PutLogEvents"
    ]
  }
}

# Let eks-blueprints-addons module handle Karpenter node IAM role automatically

# Stage 1: Karpenter controller only (runs first to provide compute)
# module "karpenter_controller" {
#   source  = "aws-ia/eks-blueprints-addons/aws"
#   version = "1.22.0"

#   tags = var.tags

#   cluster_name      = module.cluster.cluster_name
#   cluster_endpoint  = module.cluster.cluster_endpoint
#   oidc_provider_arn = module.cluster.oidc_provider_arn
#   cluster_version   = module.cluster.cluster_version

#   # Only Karpenter controller in this stage
#   enable_karpenter                  = var.addons.enable_karpenter
#   karpenter_enable_spot_termination = true
#   karpenter = merge(var.addons.karpenter_config, {
#     repository_username = data.aws_ecrpublic_authorization_token.token.user_name
#     repository_password = data.aws_ecrpublic_authorization_token.token.password
#     set = [
#       {
#         name  = "settings.featureGates.spotToSpotConsolidation"
#         value = "true"
#       },
#       {
#         name  = "settings.featureGates.driftEnabled"
#         value = "true"
#       },
#       {
#         name  = "controller.resources.requests.cpu"
#         value = "1"
#       },
#       {
#         name  = "controller.resources.requests.memory"
#         value = "4Gi"
#       },
#       {
#         name  = "controller.resources.limits.cpu"
#         value = "2"
#       },
#       {
#         name  = "controller.resources.limits.memory"
#         value = "4Gi"
#       },
#       {
#         name  = "webhook.enabled"
#         value = "false"
#       },
#       {
#         name  = "dnsPolicy"
#         value = "Default"
#       },
#     ]
#   })

#   karpenter_node = {
#     create_iam_role       = false
#     iam_role_name         = aws_iam_role.karpenter_node.name
#     iam_role_arn          = aws_iam_role.karpenter_node.arn
#     instance_profile_name = aws_iam_instance_profile.karpenter_node.name
#   }

#   depends_on = [
#     time_sleep.fargate_ready
#   ]
# }

# resource "time_sleep" "karpenter_ready" {
#   depends_on = [
#     //module.karpenter_controller,
#     kubectl_manifest.karpenter_nodepool,
#     kubectl_manifest.karpenter_node_class
#   ]
#   create_duration = "30s"
# }

# Stage 2: EKS addons only (runs after Karpenter controller to enable compute-dependent addons)
module "eks_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.22.0"

  tags = var.tags

  cluster_name      = module.cluster.cluster_name
  cluster_endpoint  = module.cluster.cluster_endpoint
  oidc_provider_arn = module.cluster.oidc_provider_arn
  cluster_version   = module.cluster.cluster_version

  # Only EKS addons in this stage
  eks_addons = {
    eks-pod-identity-agent = {
      resolve_conflicts = "OVERWRITE"
      most_recent       = true
    }

    coredns = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
    }

    kube-proxy = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
    }

    vpc-cni = {
      most_recent              = true
      resolve_conflicts        = "OVERWRITE"
      service_account_role_arn = aws_iam_role.vpc_cni.arn
      configuration_values = jsonencode({
        # AWS_PROFILE=czi-si  aws eks describe-addon-configuration --addon-name vpc-cni --addon-version v1.15.1-eksbuild.1
        livenessProbeTimeoutSeconds  = 30
        readinessProbeTimeoutSeconds = 30
        resources = {
          limits = {
            cpu    = "0.5"
            memory = "256Mi"
          }
          requests = {
            cpu    = "0.5"
            memory = "256Mi"
          }
        }
        podAnnotations = {
          "prometheus.io/port"   = "61678",
          "prometheus.io/scrape" = "true"
        }
      })
    }

    aws-ebs-csi-driver = {
      resolve_conflicts        = "OVERWRITE"
      most_recent              = true
      service_account_role_arn = aws_iam_role.ebs_csi.arn
    }

    aws-mountpoint-s3-csi-driver = {
      resolve_conflicts        = "OVERWRITE"
      most_recent              = true
      service_account_role_arn = aws_iam_role.s3_csi.arn
    }
  }

  # depends_on = [
  #   time_sleep.karpenter_ready
  # ]
}

# Stage 3: All other addons (runs after Karpenter nodepool/ec2nodeclass provide compute)
module "other_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.22.0"

  tags              = var.tags
  observability_tag = null // Do not deploy observability cloudformation stack

  cluster_name      = module.cluster.cluster_name
  cluster_endpoint  = module.cluster.cluster_endpoint
  oidc_provider_arn = module.cluster.oidc_provider_arn
  cluster_version   = module.cluster.cluster_version

  enable_argocd = var.addons.enable_argocd
  argocd        = var.addons.argocd_config

  enable_aws_cloudwatch_metrics         = var.addons.enable_aws_cloudwatch_metrics
  enable_aws_load_balancer_controller   = var.addons.enable_aws_load_balancer_controller
  enable_metrics_server                 = var.addons.enable_metrics_server
  enable_cert_manager                   = var.addons.enable_cert_manager
  enable_external_secrets               = var.addons.enable_external_secrets
  external_secrets                      = var.addons.external_secrets_config
  external_secrets_secrets_manager_arns = var.addons.external_secrets_secrets_manager_arns
  external_secrets_ssm_parameter_arns   = []
  external_secrets_kms_key_arns         = []
  enable_fargate_fluentbit              = var.addons.enable_fargate_fluentbit
  enable_ingress_nginx                  = var.addons.enable_ingress_nginx
  enable_kube_prometheus_stack          = var.addons.enable_kube_prometheus_stack // conflicts with rancher monitoring (prometheus-operator)
  enable_aws_efs_csi_driver             = var.addons.enable_aws_efs_csi_driver

  cert_manager_route53_hosted_zone_arns = var.addons.cert_manager_route53_hosted_zone_arns
  cert_manager                          = var.addons.cert_manager_config
  aws_load_balancer_controller = {
    values = [yamlencode({
      clusterSecretsPermissions = {
        allowAllSecrets = true
      }
      enableServiceMutatorWebhook = false
      vpcId                       = var.vpc_id
      podDisruptionBudget = {
        maxUnavailable = 1
      }
    })]
  }

  enable_aws_for_fluentbit = var.addons.enable_aws_for_fluentbit
  aws_for_fluentbit_cw_log_group = merge(var.addons.aws_for_fluentbit_cw_log_group, {
    name = local.fluentbit_log_group_name
  })

  aws_for_fluentbit = {
    source_policy_documents = data.aws_iam_policy_document.fluentbit_policy[*].json
    //Note: We are setting the retention of the separate log groups to 15 days to account
    //for the process required to delete user data upon request.
    values = [templatefile("${path.module}/templates/fluentbit/aws-for-fluentbit-values.yaml.tpl", {
      cluster_name = local.cluster_name,
      region       = data.aws_region.current.name
      log_group    = local.fluentbit_log_group_name
      exclude_path = join(",", local.exclude_list)
    })]
  }

  enable_external_dns = var.addons.enable_external_dns
  external_dns = {
    chart_version = var.addons.external_dns_config.chart_version
    create_role   = true
    values = [templatefile("${path.module}/templates/external-dns/values.yaml", {
      txtOwnerId = local.cluster_name
      txtSuffix  = local.cluster_name
      txtPrefix  = ""
      imageTag   = var.addons.external_dns_config.image_tag
      policy     = var.addons.external_dns_config.policy
      sources    = var.addons.external_dns_config.sources
    })]
  }
  external_dns_route53_zone_arns = ["arn:aws:route53:::hostedzone/*"]

  # This stage runs after karpenter nodepool provides compute
  depends_on = [
    module.eks_addons
  ]
}