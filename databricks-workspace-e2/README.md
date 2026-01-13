## References
* [Here](https://databrickslabs.github.io/terraform-provider-databricks/overview/) is the provider docs.

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_databricks_bucket"></a> [databricks\_bucket](#module\_databricks\_bucket) | github.com/chanzuckerberg/cztack//aws-s3-private-bucket | v0.60.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.databricks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_security_group.databricks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [databricks_group.workspace_admins](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group.workspace_users](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [databricks_group_member.workspace_admins](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_group_member.workspace_users](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_mws_credentials.databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_credentials) | resource |
| [databricks_mws_networks.networking](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_networks) | resource |
| [databricks_mws_permission_assignment.tfe_service_principal_admin](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_permission_assignment) | resource |
| [databricks_mws_permission_assignment.workspace_admins](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_permission_assignment) | resource |
| [databricks_mws_permission_assignment.workspace_users](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_permission_assignment) | resource |
| [databricks_mws_storage_configurations.databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_storage_configurations) | resource |
| [databricks_mws_workspaces.databricks](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_workspaces) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.databricks-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.databricks-setup-assume-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [databricks_service_principal.tfe_service_principal](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/service_principal) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databricks_external_id"></a> [databricks\_external\_id](#input\_databricks\_external\_id) | The ID of a Databricks root account. | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | The environment / stage. Aka staging, dev, prod. | `string` | n/a | yes |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | Set default owner of all objects within bucket (e.g., bucket vs. object owner) | `string` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | n/a | yes |
| <a name="input_passable_role_arn"></a> [passable\_role\_arn](#input\_passable\_role\_arn) | A role to allow the cross-account role to pass to other accounts | `string` | `""` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnets. | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | A high level name, typically the name of the site. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | The service. Aka databricks-workspace. | `string` | n/a | yes |
| <a name="input_tfe_service_principal_id"></a> [tfe\_service\_principal\_id](#input\_tfe\_service\_principal\_id) | ID for the service principal for Terraform Enterprise, if available. Will be added as a workspace admin | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC. | `string` | n/a | yes |
| <a name="input_workspace_admins"></a> [workspace\_admins](#input\_workspace\_admins) | List of principal IDs to be added to the workspace admins group. | `list(string)` | `[]` | no |
| <a name="input_workspace_name_override"></a> [workspace\_name\_override](#input\_workspace\_name\_override) | Override the workspace name. If not set, the workspace name will be set to the project, env, and service. | `string` | `null` | no |
| <a name="input_workspace_users"></a> [workspace\_users](#input\_workspace\_users) | List of principal IDs to be added to the workspace users group. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the AWS IAM role. |
| <a name="output_workspace_admins_group_id"></a> [workspace\_admins\_group\_id](#output\_workspace\_admins\_group\_id) | ID of the workspace admins group. |
| <a name="output_workspace_admins_group_name"></a> [workspace\_admins\_group\_name](#output\_workspace\_admins\_group\_name) | Name of the workspace admins group. |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | ID of the workspace. |
| <a name="output_workspace_url"></a> [workspace\_url](#output\_workspace\_url) | Url of the deployed workspace. |
| <a name="output_workspace_users_group_id"></a> [workspace\_users\_group\_id](#output\_workspace\_users\_group\_id) | ID of the workspace users group. |
| <a name="output_workspace_users_group_name"></a> [workspace\_users\_group\_name](#output\_workspace\_users\_group\_name) | Name of the workspace users group. |
<!-- END -->
