locals {
  # default policy attributes that can be overridden but are otherwise 
  # included for each policy
  default_policy = {
    "custom_tags.Cluster_Policy" : {
      "type" : "fixed",
      "value" : var.policy_name
    },
    "custom_tags.Databricks_Workspace_Id" : {
      "type" : "fixed",
      "value" : var.databricks_workspace_id
    },
    "custom_tags.Databricks_Host" : {
      "type" : "fixed",
      "value" : var.databricks_host
    },
  }

  # Workaround for looping over grantees and setting resource count
  inherited_cluster_policy_grantees = toset([for grantee in var.grantees : grantee if var.policy_family_id != null])
  custom_cluster_policy_grantees    = toset([for grantee in var.grantees : grantee if var.policy_family_id == null])
}

## Messy implementation below - cannot set policy_family_id and/or policy_family_definiton_overrides 
## if definition is present, and setting them to null still triggers an error from the provider, so 
## we duplicate the setup and set a count on the var being present

### if inherited cluster policy
resource "databricks_cluster_policy" "inherited_cluster_policy" {
  count = var.policy_family_id != null ? 1 : 0

  name                               = var.policy_name
  policy_family_definition_overrides = jsonencode(merge(local.default_policy, var.policy_overrides))
  policy_family_id                   = var.policy_family_id
}

resource "databricks_permissions" "can_use_inherited_cluster_policy" {
  count             = length(local.inherited_cluster_policy_grantees) > 0 ? 1 : 0
  cluster_policy_id = databricks_cluster_policy.inherited_cluster_policy[0].id

  # TF provider requires a dynamic block rather than a for_each - for_each will override permissions
  dynamic "access_control" {
    for_each = local.inherited_cluster_policy_grantees
    content {
      group_name       = access_control.value
      permission_level = "CAN_USE"
    }
  }
}

### if custom cluster policy
resource "databricks_cluster_policy" "custom_cluster_policy" {
  count = var.policy_family_id == null ? 1 : 0

  name       = var.policy_name
  definition = jsonencode(merge(local.default_policy, var.policy_overrides))
}

resource "databricks_permissions" "can_use_custom_cluster_policy" {
  count             = length(local.custom_cluster_policy_grantees) > 0 ? 1 : 0
  cluster_policy_id = databricks_cluster_policy.custom_cluster_policy[0].id

  # TF provider requires a dynamic block rather than a for_each - for_each will override permissions
  dynamic "access_control" {
    for_each = local.custom_cluster_policy_grantees
    content {
      group_name       = access_control.value
      permission_level = "CAN_USE"
    }
  }
}