# TFE Management
<!-- bump2 -->
<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.51 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | ~> 0.51 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_team_access.tfe_team_access](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_workspace.ws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_workspace_settings.test](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_settings) | resource |
| [tfe_ssh_key.github](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/ssh_key) | data source |
| [tfe_team.teams](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/team) | data source |
| [tfe_workspace.tfe](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accounts"></a> [accounts](#input\_accounts) | n/a | `any` | n/a | yes |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Automatically apply merged changes. | `bool` | `true` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | The git branch used by default. | `string` | `""` | no |
| <a name="input_default_remote_apply"></a> [default\_remote\_apply](#input\_default\_remote\_apply) | Whether to allow local applies for this workspace | `bool` | `true` | no |
| <a name="input_default_terraform_version"></a> [default\_terraform\_version](#input\_default\_terraform\_version) | Unless overridden in a component, use this terraform version. | `string` | `"1.2.6"` | no |
| <a name="input_default_trigger_prefixes"></a> [default\_trigger\_prefixes](#input\_default\_trigger\_prefixes) | List of directories which will, by default, trigger runs. | `list(string)` | `[]` | no |
| <a name="input_enable_global"></a> [enable\_global](#input\_enable\_global) | Enable the global component in TFE. | `bool` | `true` | no |
| <a name="input_env_defaults"></a> [env\_defaults](#input\_env\_defaults) | A map of environment names to default configuration. Can be overwriten by each component. | `any` | `{}` | no |
| <a name="input_envs"></a> [envs](#input\_envs) | n/a | `any` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | n/a | `string` | n/a | yes |
| <a name="input_repo"></a> [repo](#input\_repo) | n/a | `string` | n/a | yes |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | n/a | `string` | `"czi-si-tfe"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `object({ project : string, env : string, service : string, owner : string, managedBy : string })` | n/a | yes |
| <a name="input_teams_with_admin_access"></a> [teams\_with\_admin\_access](#input\_teams\_with\_admin\_access) | Teams which can admin (state). | `list(string)` | `[]` | no |
| <a name="input_teams_with_plan_access"></a> [teams\_with\_plan\_access](#input\_teams\_with\_plan\_access) | Teams which can run a plan. | `list(string)` | `[]` | no |
| <a name="input_teams_with_read_access"></a> [teams\_with\_read\_access](#input\_teams\_with\_read\_access) | Teams which can view components in TFE. | `list(string)` | `[]` | no |
| <a name="input_teams_with_write_access"></a> [teams\_with\_write\_access](#input\_teams\_with\_write\_access) | Teams which can write (state). | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END -->
