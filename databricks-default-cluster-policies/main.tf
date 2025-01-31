data "aws_caller_identity" "current" {
  provider = aws
}
locals {
  power_user_group_name = var.power_user_group_name
  all_users_group_name  = "users"

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
    "aws_attributes.zone_id": {
      "type": "unlimited",
      "hidden": false
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

module "personal_compute_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Personal Compute"
  policy_family_id        = local.default_policy_family_ids["personal_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, local.personal_instance_pools, {
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcip]+[3-5]+[d]*\\.[0-1]{0,1}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcip]+[3-5]+[d]*\\.[0-1]{0,1}xlarge)",
      "hidden" : false
    },
    "aws_attributes.availability" : {
      "type" : "allowlist",
      "values" : [
        "ON_DEMAND",
        "SPOT_WITH_FALLBACK"
      ],
      "hidden" : false
    },
    "runtime_engine" : {
      "type" : "unlimited",
      "defaultValue" : "STANDARD",
      "hidden" : false
    },
  })
  grantees = [local.all_users_group_name]
}

module "large_personal_compute_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Large Personal Compute"
  policy_family_id        = local.default_policy_family_ids["personal_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcip]+[3-6]+[di]*\\.[0-8]{0,1}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([rcip]+[3-6]+[di]*\\.[0-8]{0,1}xlarge)",
      "hidden" : false
    },
  })
  grantees = ["${var.policy_name_prefix}Large Personal Compute"]
}

module "power_user_compute_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Power User Compute"
  policy_family_id        = local.default_policy_family_ids["power_user_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autoscale.max_workers" : {
      "type" : "range",
      "defaultValue" : 10,
      "maxValue" : 20
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([grci]+[3-5]+[dn]*\\.[0-8]{0,1}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([grci]+[3-5]+[dn]*\\.[0-8]{0,1}xlarge)",
      "hidden" : false
    },
  })

  grantees = [local.power_user_group_name, "${var.policy_name_prefix}Power User Compute"]
}

module "job_compute_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Job Compute"
  policy_family_id        = local.default_policy_family_ids["job_compute"]

  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "aws_attributes.availability" : {
      "type" : "allowlist",
      "values" : [
        "ON_DEMAND",
        "SPOT_WITH_FALLBACK"
      ],
      "hidden" : false
    }
  })

  grantees = [local.power_user_group_name, "${var.policy_name_prefix}Job Compute"]
}

module "small_job_compute_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Small Job Compute"
  policy_family_id        = local.default_policy_family_ids["job_compute"]

  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "spark_conf.spark.databricks.cluster.profile" : {
      "type" : "unlimited",
      "defaultValue" : "singleNode",
      "hidden" : false
    }
  })

  grantees = [local.power_user_group_name, "${var.policy_name_prefix}Small Job Compute"]
}

## Fully custom policies
module "large_gpu_large_clusters_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Large GPU Large Clusters"
  policy_family_id        = local.default_policy_family_ids["power_user_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autoscale.max_workers" : {
      "type" : "range",
      "minValue" : 1,
      "maxValue" : 64,
      "defaultValue" : 2
    },
    "autoscale.min_workers" : {
      "type" : "range",
      "minValue" : 1,
      "maxValue" : 64,
      "defaultValue" : 1
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120
    },
    "node_type_id" : {
      "type" : "allowlist",
      "values" : [
        "g4dn.xlarge",
        "g4dn.2xlarge",
        "g4dn.4xlarge",
        "g4dn.8xlarge",
        "g4dn.12xlarge",
        "g4dn.16xlarge",
        "g5.xlarge",
        "g5.2xlarge",
        "g5.4xlarge",
        "g5.8xlarge",
        "g5.12xlarge",
        "g5.16xlarge",
        "g5.24xlarge",
        "g5.48xlarge"
      ],
      "defaultValue" : "g4dn.xlarge"
    },
  })
  grantees = ["${var.policy_name_prefix}Large GPU Large Clusters"]
}

module "large_gpu_personal_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Large GPU Personal"
  policy_family_id        = local.default_policy_family_ids["personal_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120
    }
    "node_type_id" : {
      "type" : "allowlist",
      "values" : [
        "g4dn.xlarge",
        "g4dn.2xlarge",
        "g4dn.4xlarge",
        "g4dn.8xlarge",
        "g4dn.12xlarge",
        "g4dn.16xlarge",
        "g5.xlarge",
        "g5.8xlarge",
        "g5.4xlarge",
        "g5.48xlarge",
        "g5.2xlarge",
        "g5.24xlarge",
        "g5.16xlarge",
        "g5.12xlarge"
      ],
      "defaultValue" : "g4dn.xlarge"
    },
  })
  grantees = ["${var.policy_name_prefix}Large GPU Personal"]
}

module "large_gpu_small_clusters_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Large GPU Small Clusters"
  policy_family_id        = local.default_policy_family_ids["power_user_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autoscale.max_workers" : {
      "type" : "range",
      "minValue" : 1,
      "maxValue" : 3,
      "defaultValue" : 2
    },
    "autoscale.min_workers" : {
      "type" : "range",
      "minValue" : 1,
      "maxValue" : 3,
      "defaultValue" : 1
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120
    },
    "node_type_id" : {
      "type" : "allowlist",
      "values" : [
        "g4dn.xlarge",
        "g4dn.2xlarge",
        "g4dn.4xlarge",
        "g4dn.8xlarge",
        "g4dn.12xlarge",
        "g4dn.16xlarge",
        "g5.xlarge",
        "g5.8xlarge",
        "g5.4xlarge",
        "g5.48xlarge",
        "g5.2xlarge",
        "g5.24xlarge",
        "g5.16xlarge",
        "g5.12xlarge"
      ],
      "defaultValue" : "g4dn.xlarge"
    },
  })
  grantees = ["${var.policy_name_prefix}Large GPU Small Clusters"]
}

module "small_clusters" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Small Clusters"
  policy_family_id        = local.default_policy_family_ids["power_user_compute"]
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autoscale.max_workers" : {
      "type" : "range",
      "maxValue" : 3,
      "defaultValue" : 3
    },
    "autoscale.min_workers" : {
      "type" : "fixed",
      "value" : 1,
      "hidden" : true
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 120,
      "hidden" : false
    },
    "data_security_mode" : {
      "type" : "whitelist",
      "values" : [
        "USER_ISOLATION",
        "SINGLE_USER"
      ]
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "[rmci][3-5][rnad]*\\.[0-2]{0,1}xlarge",
      "hidden" : false
    },
    "enable_elastic_disk" : {
      "type" : "fixed",
      "value" : false,
      "hidden" : true
    },
    "instance_pool_id" : {
      "type" : "forbidden",
      "hidden" : true
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "[rmci][3-5][rnad]*\\.[0-2]{0,1}xlarge",
      "hidden" : false
    },
  })
  grantees = ["${var.policy_name_prefix}Small Clusters"]
}

module "superset_compute_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Superset Compute"

  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 60
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([grci]+[3-5]+[dn]*\\.[0-2]{0,1}xlarge)",
      "hidden" : false
    },
    "node_type_id" : {
      "type" : "regex",
      "pattern" : "([grci]+[3-5]+[dn]*\\.[0-2]{0,1}xlarge)",
      "hidden" : false
    },
    "driver_instance_pool_id" : {
      "type" : "unlimited",
      "isOptional" : true,
      "defaultValue" : "superset_pool"
    },
    "instance_pool_id" : {
      "type" : "unlimited",
      "isOptional" : true,
      "defaultValue" : "superset_pool"
    },
  })
  grantees = ["${var.policy_name_prefix}Superset Compute"]
}

module "single_node_cluster_policy" {
  source = "../databricks-cluster-policy"

  databricks_host         = var.databricks_host
  databricks_workspace_id = var.databricks_workspace_id
  policy_name             = "${var.policy_name_prefix}Single Node Job Compute"
  policy_overrides = merge(local.logging_override, local.addtnl_global_overrides, {
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([mrcip]+[3-5]+[d]*\\.[0-1]{0,1}xlarge)",
      "hidden" : false
    },
    "aws_attributes.availability": {
      "type": "allowlist",
      "values": [
        "ON_DEMAND",
        "SPOT_WITH_FALLBACK"
      ],
      "hidden": false
    },
    "runtime_engine": {
      "type": "unlimited",
      "defaultValue": "STANDARD",
      "hidden": false
    },
    "spark_conf.spark.databricks.cluster.profile":{
      "type":"fixed",
      "value":"singleNode",
      "hidden":true
    },
    "num_workers":{
      "type":"range",
      "maxValue":0
    }
    "data_security_mode" : {
      "type" : "whitelist",
      "values" : [
        "USER_ISOLATION",
        "SINGLE_USER"
      ]
    },
    "driver_node_type_id" : {
      "type" : "regex",
      "pattern" : "([mrcip]+[3-5]+[d]*\\.[0-1]{0,1}xlarge)",
      "hidden" : false
    },
    "enable_elastic_disk" : {
      "type" : "fixed",
      "value" : false,
      "hidden" : true
    },
    "instance_pool_id" : {
      "type" : "forbidden",
      "hidden" : true
    },
  })
  grantees = ["${var.policy_name_prefix}Single Node Job Compute"]
}