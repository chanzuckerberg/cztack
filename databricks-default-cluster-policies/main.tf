data "aws_caller_identity" "current" {
  provider = aws
}
locals {
  default_policy_family_ids = {
    job_compute : "job-cluster",
    legacy_shared_compute : "shared-data-science",
    personal_compute : "personal-vm",
    power_user_compute : "power-user",
    shared_compute : "shared-compute",
  }

  default_cluster_instance_profile     = "cluster-log-cluster-instance-profile"
  default_cluster_instance_profile_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/databricks/${local.default_cluster_instance_profile}"

  logging_override = {
    # set log destination - one prefix per workspace since cluster ids are only unique per workspace
    "cluster_log_conf.path" : {
      "type" : "fixed",
      "value" : "s3://${var.databricks_log_bucket}/cluster-logs/${var.databricks_workspace_id}"
    },

    "cluster_log_conf.type" : {
      "type" : "fixed",
      "value" : "S3"
    }

    # require using an instance profile that has logging enabled
    "aws_attributes.instance_profile_arn" : {
      "type" : "allowlist",
      "values" : concat(
      [local.default_cluster_instance_profile_arn], var.additional_instance_profile_arns),
      "defaultValue" : local.default_cluster_instance_profile_arn
    }
  }
  personal_instance_pools = var.personal_compute_pool_ids != [] ? {
    "instance_pool_id" : {
      "type" : "allowlist",
      "isOptional" : true,
      "values" : var.personal_compute_pool_ids
    },
    "driver_node_type_id" : {
      "type" : "allowlist",
      "isOptional" : true,
      "values" : var.personal_compute_pool_ids
    }
  } : {}
  addtnl_global_overrides = {
    # Allow users to specify the availability zone
    "aws_attributes.zone_id" : {
      "type" : "unlimited",
      "hidden" : false
    },
    # Allow EBS
    "enable_elastic_disk": {
      "type": "unlimited",
      "defaultValue": true,
      "hidden" : false
    },
    # Allow users to set availability type to on-demand or spot
    "aws_attributes.availability" : {
      "type" : "allowlist",
      "values" : [
        "ON_DEMAND",
        "SPOT_WITH_FALLBACK",
        "SPOT"
      ],
      "hidden" : false
    }
  }
}

## Modified Databricks defaults
module "legacy_shared_compute_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Legacy Shared Compute"
  policy_family_id        = local.default_policy_family_ids["legacy_shared_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "data_security_mode" : {
      "type" : "fixed",
      "hidden" : true,
      "value" : "NONE"
    }
  })
}

## Before addinging new policies, please create an account-level user group to use
## for assigning permissions. This prevents users from being removed from policies
## when the workspaces are updated by TFE.

## CPU policies

module "single_node_cpu_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Single Node CPU Compute"
  policy_family_id        = local.default_policy_family_ids["personal_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, local.personal_instance_pools, {
    "is_single_node" : {
      "type" : "fixed",
      "value" : true
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcizm]+[3-8]+[idn]*\\.[0-9]{0,2}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcizm]+[3-8]+[idn]*\\.[0-9]{0,2}xlarge)",
      "hidden" : false
    },
    "runtime_engine" : {
      "type" : "unlimited",
      "defaultValue" : "STANDARD",
      "hidden" : false
    },
  })
  grantees = ["${var.policy_name_prefix}Single Node CPU Compute"]
}

module "multi_node_cpu_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Multi Node CPU Compute"
  policy_family_id        = local.default_policy_family_ids["power_user_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autoscale.max_workers" : {
      "type" : "range",
      "defaultValue" : 10,
      "maxValue" : 2000
    },
    "autoscale.min_workers" : {
      "type" : "range",
      "defaultValue" : 1,
      "minValue" : 1
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcizm]+[3-8]+[idn]*\\.[0-9]{0,2}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcizm]+[3-8]+[idn]*\\.[0-9]{0,2}xlarge)",
      "hidden" : false
    },
    "runtime_engine" : {
      "type" : "unlimited",
      "defaultValue" : "STANDARD",
      "hidden" : false
    },
  })

  grantees = ["${var.policy_name_prefix}Multi Node CPU Compute"]
}

module "multi_node_cpu_job_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Multi Node CPU Job"
  policy_family_id        = local.default_policy_family_ids["job_compute"]

  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autoscale.max_workers" : {
      "type" : "range",
      "defaultValue" : 10,
      "maxValue" : 2000
    },
    "autoscale.min_workers" : {
      "type" : "range",
      "defaultValue" : 1,
      "minValue" : 1
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcizm]+[3-8]+[idn]*\\.[0-9]{0,2}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcizm]+[3-8`]+[dn]*\\.[0-32]{0,1}xlarge)",
      "hidden" : false
    },
  })

  grantees = ["${var.policy_name_prefix}Multi Node CPU Job"]
}

module "single_node_cpu_job_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Single Node CPU Job"
  policy_family_id        = local.default_policy_family_ids["job_compute"]

  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "is_single_node" : {
      "type" : "fixed",
      "value" : true
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcizm]+[3-8]+[idn]*\\.[0-9]{0,2}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcizm]+[3-8]+[idn]*\\.[0-9]{0,2}xlarge)",
      "hidden" : false
    },
  })

  grantees = ["${var.policy_name_prefix}Single Node CPU Job"]
}

## GPU policies

module "multi_node_gpu_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Multi Node GPU Compute"
  policy_family_id        = local.default_policy_family_ids["power_user_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autoscale.max_workers" : {
      "type" : "range",
      "defaultValue" : 10,
      "maxValue" : 1000
    },
    "autoscale.min_workers" : {
      "type" : "range",
      "defaultValue" : 1,
      "minValue" : 1
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([gp]+[2-6]+[idn]*\\.[0-48]{0,1}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([gp]+[2-6]+[idn]*\\.[0-48]{0,1}xlarge)",
      "hidden" : false
    },
  })
  grantees = ["${var.policy_name_prefix}Multi Node GPU Compute"]
}

module "single_node_gpu_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Single Node GPU Compute"
  policy_family_id        = local.default_policy_family_ids["personal_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120
    },
    "is_single_node" : {
      "type" : "fixed",
      "value" : true
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([gp]+[2-6]+[idn]*\\.[0-48]{0,1}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([gp]+[2-6]+[idn]*\\.[0-48]{0,1}xlarge)",
      "hidden" : false
    },
  })
  grantees = ["${var.policy_name_prefix}Single Node GPU Compute"]
}

module "multi_node_gpu_job_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Multi Node GPU Job"
  policy_family_id        = local.default_policy_family_ids["job_compute"]

  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autoscale.max_workers" : {
      "type" : "range",
      "defaultValue" : 10,
      "maxValue" : 1000
    },
    "autoscale.min_workers" : {
      "type" : "range",
      "defaultValue" : 1,
      "minValue" : 1
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([gp]+[2-6]+[idn]*\\.[0-48]{0,1}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([gp]+[2-6]+[idn]*\\.[0-48]{0,1}xlarge)",
      "hidden" : false
    },
  })

  grantees = ["${var.policy_name_prefix}Multi Node GPU Job"]
}

module "single_node_gpu_job_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Single Node GPU Job"
  policy_family_id        = local.default_policy_family_ids["job_compute"]

  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([gp]+[2-6]+[idn]*\\.[0-48]{0,1}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([gp]+[2-6]+[idn]*\\.[0-48]{0,1}xlarge)",
      "hidden" : false
    },
    "is_single_node" : {
      "type" : "fixed",
      "value" : true
    },
  })

  grantees = ["${var.policy_name_prefix}Single Node GPU Job"]
}