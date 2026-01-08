# https://www.terraform.io/docs/cloud/users-teams-organizations/permissions.html
locals {

  defaults = {
    terraform_version = var.default_terraform_version
    auto_apply        = var.auto_apply
    trigger_prefixes  = var.default_trigger_prefixes
    remote_apply      = var.default_remote_apply
    branch            = var.default_branch
  }

  component_list = [
    for envName, env in var.envs : [
      for componentName, component in env : {
        join("-", [envName, componentName]) = merge(
          local.defaults,
          lookup(var.env_defaults, envName, {}),
          component,
          { working_directory : join("/", ["terraform", "envs", envName, componentName]) },
        )
      }
    ]
  ]

  # This *should* be unnecessary, but we're working around a bug:
  # https://github.com/hashicorp/terraform/issues/22404
  components = merge(flatten([local.component_list])...)

  global = var.enable_global ? {
    "global" = merge(local.defaults, {
      name              = "global"
      working_directory = "terraform/global"
    })
  } : {}

  workspaces = merge(
    local.global,

    {
      for a, c in var.accounts :
      join("-", ["accounts", a]) => merge(local.defaults, c, {
        working_directory = join("/", ["terraform", "accounts", a])
      })
    },
    local.components
  )

  # Keys are a concatenation of workspace name and team name, uniquely identifying the access level a given team has in
  # a given TFE environment. Precedence happens in the order of the maps below: later entries overwrite earlier entries
  # with the same key.
  #
  # - global read perms
  # - "extra" read perms granted to a team in a given env
  # - global plan perms
  # - "extra" plan perms granted to a team in a given env
  # - global write perms
  # - "extra" write perms granted to a team in a given env
  # - admin perms granted to a team in a given env
  # - "override" read perms granted to a team in a given env
  # - "override" plan perms granted to a team in a given env
  # - "override" write perms granted to a team in a given env
  #
  # Per-workspace granular permissions override global permissions (either increasing or decreasing access level).
  # "Override" permissions override global and "extra" permissions.
  # Global write overrides global plan, which overrides global read, and analogously for "extra" and "override" perms.
  team_access = merge(
    # Apply global "read."
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(var.teams_with_read_access) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "read"
        }
      }
    ]...),
    # Apply "extra" per-workspace read overrides.
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(lookup(lookup(workspace, "extra_team_permissions", {}), "read", [])) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "read"
        }
      }
    ]...),
    # Apply global plan.
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(var.teams_with_plan_access) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "plan"
        }
      }
    ]...),
    # Apply "extra" per-workspace plan overrides.
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(lookup(lookup(workspace, "extra_team_permissions", {}), "plan", [])) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "plan"
        }
      }
    ]...),
    # Apply global write.
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(var.teams_with_write_access) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "write"
        }
      }
    ]...),
    # Apply "extra" per-workspace write overrides.
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(lookup(lookup(workspace, "extra_team_permissions", {}), "write", [])) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "write"
        }
      }
    ]...),
    # Apply global admin.
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(var.teams_with_admin_access) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "admin"
        }
      }
    ]...),
    # Apply "extra" per-workspace admin overrides.
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(lookup(lookup(workspace, "extra_team_permissions", {}), "admin", [])) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "admin"
        }
      }
    ]...),
    # Apply "override" per-workspace read overrides.
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(lookup(lookup(workspace, "override_team_permissions", {}), "read", [])) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "read"
        }
      }
    ]...),
    # Apply "override" per-workspace plan overrides.
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(lookup(lookup(workspace, "override_team_permissions", {}), "plan", [])) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "plan"
        }
      }
    ]...),
    # Apply "override" per-workspace write overrides.
    merge([
      for workspace_name, workspace in local.workspaces : {
        for team_name in distinct(lookup(lookup(workspace, "override_team_permissions", {}), "write", [])) : "${workspace_name}-${team_name}" => {
          workspace_id = tfe_workspace.ws[workspace_name].id
          team_id      = data.tfe_team.teams[team_name].id
          access       = "write"
        }
      }
    ]...),
  )
}

data "tfe_ssh_key" "github" {
  name         = var.ssh_key_name
  organization = var.organization
}

data "tfe_workspace" "tfe" {
  name         = "tfe"
  organization = var.organization
}

# Forces the workspace to utilize the organization's default settings
resource "tfe_workspace_settings" "test" {
  for_each            = tfe_workspace.ws
  global_remote_state = true
  workspace_id        = each.value.id
}

resource "tfe_workspace" "ws" {
  for_each = local.workspaces

  name              = each.key
  working_directory = each.value.working_directory
  terraform_version = each.value.terraform_version
  # At a minimum, we need the working directory in the list of trigger prefixes, otherwise
  # if the set of trigger_prefixes is empty (i.e. the default), then the workspace will
  # try to use Glob patterns with no values. This causes it to never trigger.
  trigger_prefixes              = concat(each.value.trigger_prefixes, [each.value.working_directory])
  auto_apply                    = each.value.auto_apply
  organization                  = var.organization
  ssh_key_id                    = data.tfe_ssh_key.github.id
  structured_run_output_enabled = false
  force_delete                  = true

  dynamic "vcs_repo" {
    for_each = data.tfe_workspace.tfe.vcs_repo[0].oauth_token_id != null && data.tfe_workspace.tfe.vcs_repo[0].oauth_token_id != "" ? [1] : []
    content {
      identifier     = var.repo
      oauth_token_id = data.tfe_workspace.tfe.vcs_repo[0].oauth_token_id
      branch         = each.value.branch
    }
  }

  dynamic "vcs_repo" {
    for_each = data.tfe_workspace.tfe.vcs_repo[0].oauth_token_id == null || data.tfe_workspace.tfe.vcs_repo[0].oauth_token_id == "" ? [1] : []
    content {
      identifier                 = var.repo
      github_app_installation_id = data.tfe_workspace.tfe.vcs_repo[0].github_app_installation_id
      branch                     = each.value.branch
    }
  }
}

data "tfe_team" "teams" {
  for_each = toset(concat(
    var.teams_with_read_access,
    var.teams_with_plan_access,
    var.teams_with_write_access,
    distinct(flatten([
      for workspace in local.workspaces :
      # Being explicit here in case we add more fields to these objects in the future...
      concat(
        lookup(lookup(workspace, "extra_team_permissions", {}), "read", []),
        lookup(lookup(workspace, "extra_team_permissions", {}), "plan", []),
        lookup(lookup(workspace, "extra_team_permissions", {}), "write", []),
        lookup(lookup(workspace, "extra_team_permissions", {}), "admin", []),
        lookup(lookup(workspace, "override_team_permissions", {}), "read", []),
        lookup(lookup(workspace, "override_team_permissions", {}), "plan", []),
        lookup(lookup(workspace, "override_team_permissions", {}), "write", []),
      )
    ])),
  ))
  name         = each.value
  organization = var.organization
}

resource "tfe_team_access" "tfe_team_access" {
  for_each     = local.team_access
  access       = each.value.access
  team_id      = each.value.team_id
  workspace_id = each.value.workspace_id
}
