# AWSServiceRoleForEC2Spot is account-global: only one may exist per account and it
# does not accept a custom suffix. When several clusters share an account, exactly one
# should own the role. Set create_ec2_spot_service_linked_role = false on the others.
resource "aws_iam_service_linked_role" "ec2_spot" {
  count            = var.create_ec2_spot_service_linked_role ? 1 : 0
  aws_service_name = "spot.amazonaws.com"
}

# Existing clusters manage the role at the unindexed address. Adopt it into the
# counted address so enabling the toggle does not destroy and recreate the role.
moved {
  from = aws_iam_service_linked_role.ec2_spot
  to   = aws_iam_service_linked_role.ec2_spot[0]
}

locals {
  karpenter_odcr_enabled = var.addons.enable_karpenter && try(var.addons.enable_karpenter_capacity_reservation, false)

  karpenter_capacity_reservation_ec2_node_class_name = try(var.addons.karpenter_capacity_reservation.ec2_node_class_name, "odcr")

  karpenter_ec2_node_class_spec = {
    "amiFamily"        = "AL2023"
    "amiSelectorTerms" = var.addons.karpenter_ami_selector_terms
    "kubelet" = {
      "systemReserved" : {
        "cpu"    = "100m"
        "memory" = "100Mi"
      }
      "podsPerCore" = 14
    }
    "blockDeviceMappings" = [
      {
        "deviceName" = "/dev/xvda"
        "ebs" = {
          "deleteOnTermination" = true
          "encrypted"           = true
          "volumeSize"          = "${var.docker_storage_size}Gi"
          "volumeType"          = "gp3"
        }
      },
    ]
    "role"                       = aws_iam_role.karpenter_node.name
    "securityGroupSelectorTerms" = [{ tags = local.karpenter_discovery }, { tags = local.karpenter_discovery_per_cluster }]
    "subnetSelectorTerms"        = [{ tags = local.karpenter_discovery }, { tags = local.karpenter_discovery_per_cluster }]
    "tags"                       = merge(var.tags, { "managedBy" = "karpenter" })
  }

  default_nodepool_spec = {
    "disruption" = {
      "consolidationPolicy" = "WhenEmptyOrUnderutilized"
      "consolidateAfter"    = "24h"
    }

    "template" = {
      "spec" = {
        "terminationGracePeriod" = "1h"
        "expireAfter"            = "${15 * 24}h"

        "nodeClassRef" = {
          "group" = "karpenter.k8s.aws"
          "kind"  = "EC2NodeClass"
          "name"  = "default"
        }
        "requirements" = [
          {
            "key"      = "kubernetes.io/arch"
            "operator" = "In"
            "values" = [
              "arm64",
              "amd64",
            ]
          },
          {
            "key"      = "karpenter.sh/capacity-type"
            "operator" = "In"
            "values" = [
              "spot",
              "on-demand",
            ]
          },
          {
            "key"      = "kubernetes.io/os"
            "operator" = "In"
            "values" = [
              "linux",
            ]
          },
          {
            "key"      = "karpenter.k8s.aws/instance-size"
            "operator" = "NotIn"
            "values" = [
              "nano",
              "micro",
              "small",
            ]
          },
          # Required to make sure that our instances have enough ENIs on them
          # to work with the ebs-csi-node daemonset.
          {
            "key"      = "karpenter.k8s.aws/instance-cpu"
            "operator" = "Gt"
            "values" = [
              "8",
            ]
          },
          # Required to work with the ebs-csi-node daemonset, as it has a scheduling
          # restrictions against a1 instances. Also, NLBs are not allowed to use the following
          # instance families in target groups if using target type instance.
          # https://github.com/kubernetes-sigs/aws-load-balancer-controller/issues/3508
          {
            "key"      = "karpenter.k8s.aws/instance-family"
            "operator" = "NotIn"
            "values" = [
              "a1",
              "c1",
              "cc1",
              "cc2",
              "cg1",
              "cg2",
              "cr1",
              "g1",
              "g2",
              "hi1",
              "hs1",
              "m1",
              "m2",
              "m3",
              "t1",
            ]
          }
        ]
      }
    }
  }

  custom_nodepool_spec    = try(var.addons.karpenter_nodepool_spec, null)
  effective_nodepool_spec = local.custom_nodepool_spec != null ? local.custom_nodepool_spec : local.default_nodepool_spec

  cilium_startup_taints = [
    {
      "key"    = "node.cilium.io/agent-not-ready"
      "effect" = "NoSchedule"
    }
  ]
  final_nodepool_spec = merge(local.effective_nodepool_spec, {
    "template" = merge(local.effective_nodepool_spec.template, {
      "spec" = merge(
        local.effective_nodepool_spec.template.spec,
        { for k, v in { "startupTaints" = local.cilium_startup_taints } : k => v
        if try(var.addons.karpenter_declare_cilium_startup_taint, false) }
      )
    })
  })
}

resource "random_id" "node_pool_name" {
  byte_length = 4
  prefix      = "nodepool-"
  keepers = {
    # Regenerate nodepool definition every time spec changes
    version = yamlencode(local.final_nodepool_spec)
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "kubectl_manifest" "karpenter_nodepool" {
  count = var.addons.enable_karpenter && var.addons.enable_default_karpenter_nodepool ? 1 : 0

  yaml_body = yamlencode({
    "apiVersion" = "karpenter.sh/v1"
    "kind"       = "NodePool"
    "metadata" = {
      "name" = random_id.node_pool_name.hex
    }
    "spec" = local.final_nodepool_spec
  })
  force_new = true
  depends_on = [
    module.karpenter_controller,
    aws_iam_service_linked_role.ec2_spot,
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "kubectl_manifest" "karpenter_node_class" {
  count = var.addons.enable_karpenter && var.addons.enable_default_karpenter_nodeclass ? 1 : 0
  yaml_body = yamlencode({
    "apiVersion" = "karpenter.k8s.aws/v1"
    "kind"       = "EC2NodeClass"
    "metadata" = {
      "name" = "default"
    }
    "spec" = local.karpenter_ec2_node_class_spec
  })
  depends_on = [
    module.karpenter_controller
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "kubectl_manifest" "karpenter_node_class_capacity_reservation" {
  count = local.karpenter_odcr_enabled ? 1 : 0
  yaml_body = yamlencode({
    "apiVersion" = "karpenter.k8s.aws/v1"
    "kind"       = "EC2NodeClass"
    "metadata" = {
      "name" = local.karpenter_capacity_reservation_ec2_node_class_name
    }
    "spec" = merge(
      local.karpenter_ec2_node_class_spec,
      {
        "capacityReservationSelectorTerms" = var.addons.karpenter_capacity_reservation.selector_terms
      }
    )
  })
  depends_on = [
    module.karpenter_controller
  ]
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "karpenter_list_instance_profiles" {
  count = var.addons.enable_karpenter ? 1 : 0

  statement {
    actions   = ["iam:ListInstanceProfiles"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "karpenter_list_instance_profiles" {
  count = var.addons.enable_karpenter ? 1 : 0

  name   = "karpenter-list-instance-profiles"
  role   = module.karpenter_controller.karpenter.iam_role_name
  policy = data.aws_iam_policy_document.karpenter_list_instance_profiles[0].json
}
