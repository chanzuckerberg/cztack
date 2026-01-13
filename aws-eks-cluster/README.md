<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.99 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 1.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.99 |
| <a name="provider_aws.us-east-1"></a> [aws.us-east-1](#provider\_aws.us-east-1) | >= 5.99 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | ~> 1.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_audit_log_ingest"></a> [audit\_log\_ingest](#module\_audit\_log\_ingest) | ../aws-firehose-s3-archiver | n/a |
| <a name="module_autocreated_ecr_writer_policy"></a> [autocreated\_ecr\_writer\_policy](#module\_autocreated\_ecr\_writer\_policy) | ../aws-iam-policy-ecr-writer | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | terraform-aws-modules/eks/aws | 19.16.0 |
| <a name="module_eks_addons"></a> [eks\_addons](#module\_eks\_addons) | aws-ia/eks-blueprints-addons/aws | 1.22.0 |
| <a name="module_eks_data_addons"></a> [eks\_data\_addons](#module\_eks\_data\_addons) | aws-ia/eks-data-addons/aws | 1.31.5 |
| <a name="module_gh_actions_role"></a> [gh\_actions\_role](#module\_gh\_actions\_role) | ../aws-iam-role-github-action | n/a |
| <a name="module_karpenter_controller"></a> [karpenter\_controller](#module\_karpenter\_controller) | aws-ia/eks-blueprints-addons/aws | 1.22.0 |
| <a name="module_other_addons"></a> [other\_addons](#module\_other\_addons) | aws-ia/eks-blueprints-addons/aws | 1.22.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.guardduty](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_iam_instance_profile.karpenter_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.node_ecr_pullthrough_cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.argocd_sa_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.child_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.karpenter_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.s3_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.assume_role_to_argo_child](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.child_secrets_rw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ecr_scanner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.list_describe_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.pull_through_cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.karpenter_node_ecr_pullthrough_cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.karpenter_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.node_ecr_pullthrough_cache_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_placement_group.az](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/placement_group) | resource |
| [aws_security_group.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.guardduty](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all_cluster_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_node_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_to_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster_to_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.node_to_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.node_to_node_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.node_to_node_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_vpc_endpoint.guardduty](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [kubectl_manifest.eso_cluster_secret_store](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.eso_cluster_secret_store_us_east_1](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_node_class](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_nodepool](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_cluster_role_binding_v1.eks-readonly](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_cluster_role_v1.eks-readonly](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_v1) | resource |
| [random_id.node_pool_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_sleep.fargate_ready](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.karpenter_ready](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ecrpublic_authorization_token.token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecrpublic_authorization_token) | data source |
| [aws_iam_policy_document.assume_role_to_argo_child](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.child_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecr_scanner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.fluentbit_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.list_describe_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pull_through_cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secrets_manager_rw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.master_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_iam_role.readonly_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssm_parameter.ami_release_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons"></a> [addons](#input\_addons) | Map of addon definitions to create | <pre>object({<br>    enable_guardduty                    = optional(bool, false)<br>    enable_aws_load_balancer_controller = optional(bool, true)<br>    enable_metrics_server               = optional(bool, true)<br>    enable_cert_manager                 = optional(bool, true)<br>    enable_aws_for_fluentbit            = optional(bool, false)<br>    enable_external_dns                 = optional(bool, true)<br>    enable_karpenter                    = optional(bool, true)<br>    enable_default_karpenter_nodepool   = optional(bool, true)<br>    enable_default_karpenter_nodeclass  = optional(bool, true)<br>    enable_aws_efs_csi_driver           = optional(bool, true)<br>    enable_argocd                       = optional(bool, false)<br>    enable_aws_cloudwatch_metrics       = optional(bool, false)<br>    enable_external_secrets             = optional(bool, false)<br>    enable_fargate_fluentbit            = optional(bool, false)<br>    enable_ingress_nginx                = optional(bool, false)<br>    enable_kube_prometheus_stack        = optional(bool, false)<br>    enable_crossplane                   = optional(bool, false) // Deprecated, use crossplane module instead<br>    fluentbit_exclude_paths             = optional(list(string), [])<br>    aws_for_fluentbit_cw_log_group = optional(any, {<br>      create          = true<br>      retention       = 7<br>      use_name_prefix = false<br>    })<br>    external_secrets_config = optional(any, {<br>      service_account_name = "external-secrets-sa",<br>      namespace            = "external-secrets",<br>      wait                 = true<br>    })<br>    external_secrets_secrets_manager_arns = optional(list(string), ["arn:aws:secretsmanager:*:*:secret:/argus/*"])<br>    argocd_config                         = optional(any, {})<br>    argocd_child_config = optional(object({<br>      enabled = optional(bool, true)<br>      root_argo_aws_account_id_to_role = optional(map(string), {<br>        "533267185808" = "argo_root_core_platform_infra_prod_eks",<br>        "471112759938" = "argo_root_core_platform_infra_dev_eks",<br>      })<br>    }), {})<br>    karpenter_config = optional(any, {<br>      chart_version = "1.6.1"<br>    })<br>    external_dns_config = optional(object({<br>      chart_version        = optional(string, "1.18.0")<br>      image_tag            = optional(string, "v0.19.0")<br>      policy               = optional(string, "upsert-only")<br>      sources              = optional(list(string), ["service", "ingress", "gateway-httproute"])<br>    }), {})<br>    cert_manager_route53_hosted_zone_arns = optional(list(string), ["arn:aws:route53:::hostedzone/*"])<br>    cert_manager_config                   = optional(any, {})<br>  })</pre> | `{}` | no |
| <a name="input_addons_data"></a> [addons\_data](#input\_addons\_data) | Map of data addons to config to create | <pre>object({<br>    enable_kubecost = optional(bool, false)<br><br>    enable_jupyterhub = optional(bool, false)<br>    jupyterhub_helm_config = optional(object({<br>      callback_url : string,<br>      client_id : string,<br>      client_secret : string,<br>      authorize_url : string,<br>      token_url : string,<br>      allowed_groups : string,<br>      jupyter_single_user_sa_name : string,<br>      issuer : string,<br>      secret_name : string,<br>      storage_class_name : string,<br>      admin_groups : string,<br>      additional_server_image : string,<br>      }), {<br>      callback_url : "",<br>      client_id : "",<br>      client_secret : "",<br>      authorize_url : "",<br>      token_url : "",<br>      allowed_groups : "",<br>      jupyter_single_user_sa_name : "",<br>      issuer : "",<br>      secret_name : "",<br>      storage_class_name : "",<br>      admin_groups : "",<br>      additional_server_image : "",<br>    })<br>  })</pre> | `{}` | no |
| <a name="input_ami_release_version"></a> [ami\_release\_version](#input\_ami\_release\_version) | AMI release version | `string` | `""` | no |
| <a name="input_authorized_aws_accounts"></a> [authorized\_aws\_accounts](#input\_authorized\_aws\_accounts) | The map of authorized AWS accounts to assume the created role. | `map(string)` | `{}` | no |
| <a name="input_authorized_github_repos"></a> [authorized\_github\_repos](#input\_authorized\_github\_repos) | Map of Github owner and repo identifiers that will be used to create a role for Github Actions to assume. Maps might look like {owner = ["reponame1", "reponame2"]} | `map(list(string))` | `{}` | no |
| <a name="input_aws_org_id"></a> [aws\_org\_id](#input\_aws\_org\_id) | The org ID this cluster will be in. May be used in assume roles and pathfinding. | `string` | `"o-56v5gp5fcu"` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) | `list(any)` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Use this to set the eks cluster name directly. NOTE: if the `cluster_name` is not specified, you will not be able to use Karpenter. | `string` | `""` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | EKS cluster version | `string` | `"1.30"` | no |
| <a name="input_docker_storage_size"></a> [docker\_storage\_size](#input\_docker\_storage\_size) | EBS Volume size in Gib that the ECS Instance uses for Docker images and metadata | `number` | `100` | no |
| <a name="input_enable_audit_s3_ingest"></a> [enable\_audit\_s3\_ingest](#input\_enable\_audit\_s3\_ingest) | Whether you want to send the EKS Audit to an s3 bucket in czi-logs. | `bool` | `false` | no |
| <a name="input_fargate_profiles"></a> [fargate\_profiles](#input\_fargate\_profiles) | Map of Fargate Profile definitions to create | `any` | `{}` | no |
| <a name="input_iam_cluster_name_prefix"></a> [iam\_cluster\_name\_prefix](#input\_iam\_cluster\_name\_prefix) | Optional prefix for the cluster IAM role name. If both `cluster_name` and `iam_cluster_name_prefix` are specified, use the value of `iam_cluster_name_prefix` as the cluster IAM role prefix; for all other cases use the `cluster_name` as a prefix. | `string` | `null` | no |
| <a name="input_identity_provider_configurations"></a> [identity\_provider\_configurations](#input\_identity\_provider\_configurations) | Set of EKS Identity Provider Configurations for non-AWS access to the EKS cluster. The key and the name should only have letters/numbers, hyphens, and underscores. Direct reference from this link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_identity_provider_config | <pre>map(<br>    object(<br>      {<br>        client_id                     = string<br>        groups_claim                  = optional(string, null)<br>        groups_prefix                 = optional(string, null)<br>        identity_provider_config_name = string<br>        issuer_url                    = string<br>        required_claims               = optional(map(string))<br>        username_claim                = optional(string, null)<br>        username_prefix               = optional(string, null)<br>      }<br>    )<br>  )</pre> | `{}` | no |
| <a name="input_logs_bucket_name"></a> [logs\_bucket\_name](#input\_logs\_bucket\_name) | name of the bucket that will hold the cloudwatch logs | `string` | `"czi-eks-cloudwatch-logs"` | no |
| <a name="input_map_accounts"></a> [map\_accounts](#input\_map\_accounts) | Additional AWS account numbers to add to the aws-auth configmap. See examples/eks\_test\_fixture/variables.tf for example format. | `list(string)` | `[]` | no |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | Additional IAM roles to add to the aws-auth configmap. Consider switching to owner\_roles and read\_only\_roles. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | Additional IAM users to add to the aws-auth configmap. See examples/eks\_test\_fixture/variables.tf for example format. | <pre>list(object({<br>    userarn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | Map of node groups for this cluster. Make sure the instance\_type correctly matches the architecture. | <pre>map(object({<br>    size          = optional(number, 1), # statically sized<br>    capacity_type = optional(string, "SPOT"),<br>    // architecture is optional, but if you do provide it you need to provide<br>    // both the ami_type and the instance_types so that you don't accidently mix and<br>    // match the wrong AMI and CPU architectures. defaults to a valid ARM architecture.<br>    architecture = optional(object({<br>      ami_type       = string<br>      instance_types = list(string)<br>      }),<br>      {<br>        ami_type       = "AL2023_ARM_64_STANDARD"<br>        instance_types = ["t4g.large"]<br>    }),<br>    taints = optional(map(object({<br>      key    = string<br>      value  = string<br>      effect = string<br>    })), {}),<br>    labels               = optional(map(string), {}),<br>    force_update_version = optional(bool, true),<br>  }))</pre> | `{}` | no |
| <a name="input_owner_roles"></a> [owner\_roles](#input\_owner\_roles) | List of IAM roles that should be added to the aws-auth configmap with system:masters group. | `list(string)` | `[]` | no |
| <a name="input_placement_group_strategy"></a> [placement\_group\_strategy](#input\_placement\_group\_strategy) | Placement group strategy for the EKS cluster (`cluster`, `partition` or `spread` are supported). Defaults to `partition` strategy. | `string` | `"partition"` | no |
| <a name="input_read_only_roles"></a> [read\_only\_roles](#input\_read\_only\_roles) | List of IAM roles that should be added to the aws-auth configmap with read-only access. | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnets to place the EKS cluster and workers within. | `list(any)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Typically fogg's var.tags | <pre>object({<br>    project : string,<br>    service : string,<br>    env : string,<br>    owner : string,<br>    managedBy : string,<br>  })</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC where the cluster and workers will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The ARN of the EKS cluster. |
| <a name="output_cluster_ca"></a> [cluster\_ca](#output\_cluster\_ca) | Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster. |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | The base64 encoded certificate data required to communicate with the EKS cluster. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The endpoint for your EKS Kubernetes API. |
| <a name="output_cluster_iam_role_name"></a> [cluster\_iam\_role\_name](#output\_cluster\_iam\_role\_name) | IAM role name of the EKS cluster. |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The name of the EKS cluster. |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster OIDC Issuer |
| <a name="output_cluster_primary_security_group_id"></a> [cluster\_primary\_security\_group\_id](#output\_cluster\_primary\_security\_group\_id) | Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console |
| <a name="output_cluster_security_group"></a> [cluster\_security\_group](#output\_cluster\_security\_group) | Security group ID attached to the EKS workers. |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | EKS cluster version |
| <a name="output_gh_action_role"></a> [gh\_action\_role](#output\_gh\_action\_role) | The roles created for GitHub Actions to interact with this cluster. |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider if enable\_irsa = true. |
| <a name="output_s3_csi_role_arn"></a> [s3\_csi\_role\_arn](#output\_s3\_csi\_role\_arn) | The ARN of the IAM role for the S3 CSI driver. |
| <a name="output_s3_csi_role_name"></a> [s3\_csi\_role\_name](#output\_s3\_csi\_role\_name) | The name of the IAM role for the S3 CSI driver. |
| <a name="output_secrets_key_arn"></a> [secrets\_key\_arn](#output\_secrets\_key\_arn) | The ARN of the KMS Key used to encrypt cluster secrets. |
| <a name="output_worker_iam_role_name"></a> [worker\_iam\_role\_name](#output\_worker\_iam\_role\_name) | IAM role name attached to EKS workers |
| <a name="output_worker_security_group"></a> [worker\_security\_group](#output\_worker\_security\_group) | Security group ID attached to the EKS workers. |
<!-- END -->