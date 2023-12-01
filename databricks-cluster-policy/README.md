# README
<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [databricks_cluster_policy.custom_cluster_policy](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/cluster_policy) | resource |
| [databricks_cluster_policy.inherited_cluster_policy](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/cluster_policy) | resource |
| [databricks_permissions.can_use_custom_cluster_policy](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.can_use_inherited_cluster_policy](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/permissions) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databricks_host"></a> [databricks\_host](#input\_databricks\_host) | Databricks host name for tagging | `string` | n/a | yes |
| <a name="input_databricks_workspace_id"></a> [databricks\_workspace\_id](#input\_databricks\_workspace\_id) | Databricks workspace\_id for tagging | `string` | n/a | yes |
| <a name="input_grantees"></a> [grantees](#input\_grantees) | Names of groups to be granted use access to the policy - must already exist | `list(string)` | `[]` | no |
| <a name="input_policy_family_id"></a> [policy\_family\_id](#input\_policy\_family\_id) | ID of policy family to inherit from | `string` | `null` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name of cluster policy | `string` | n/a | yes |
| <a name="input_policy_overrides"></a> [policy\_overrides](#input\_policy\_overrides) | Cluster policy overrides | `any` | `{}` | no |

## Outputs

No outputs.
<!-- END -->