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
| <a name="module_job_compute_cluster_policy"></a> [job\_compute\_cluster\_policy](#module\_job\_compute\_cluster\_policy) | ../databricks-cluster-policy | n/a |
| <a name="module_large_gpu_large_clusters_cluster_policy"></a> [large\_gpu\_large\_clusters\_cluster\_policy](#module\_large\_gpu\_large\_clusters\_cluster\_policy) | ../databricks-cluster-policy | n/a |
| <a name="module_large_gpu_personal_cluster_policy"></a> [large\_gpu\_personal\_cluster\_policy](#module\_large\_gpu\_personal\_cluster\_policy) | ../databricks-cluster-policy | n/a |
| <a name="module_large_gpu_small_clusters_cluster_policy"></a> [large\_gpu\_small\_clusters\_cluster\_policy](#module\_large\_gpu\_small\_clusters\_cluster\_policy) | ../databricks-cluster-policy | n/a |
| <a name="module_large_personal_compute_cluster_policy"></a> [large\_personal\_compute\_cluster\_policy](#module\_large\_personal\_compute\_cluster\_policy) | ../databricks-cluster-policy | n/a |
| <a name="module_legacy_shared_compute_cluster_policy"></a> [legacy\_shared\_compute\_cluster\_policy](#module\_legacy\_shared\_compute\_cluster\_policy) | ../databricks-cluster-policy | n/a |
| <a name="module_personal_compute_cluster_policy"></a> [personal\_compute\_cluster\_policy](#module\_personal\_compute\_cluster\_policy) | ../databricks-cluster-policy | n/a |
| <a name="module_power_user_compute_cluster_policy"></a> [power\_user\_compute\_cluster\_policy](#module\_power\_user\_compute\_cluster\_policy) | ../databricks-cluster-policy | n/a |
| <a name="module_small_clusters"></a> [small\_clusters](#module\_small\_clusters) | ../databricks-cluster-policy | n/a |
| <a name="module_small_job_compute_cluster_policy"></a> [small\_job\_compute\_cluster\_policy](#module\_small\_job\_compute\_cluster\_policy) | ../databricks-cluster-policy | n/a |
| <a name="module_superset_compute_cluster_policy"></a> [superset\_compute\_cluster\_policy](#module\_superset\_compute\_cluster\_policy) | ../databricks-cluster-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [databricks_group.power_user_group](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_instance_profile_arns"></a> [additional\_instance\_profile\_arns](#input\_additional\_instance\_profile\_arns) | Additional instance profiles to allow clusters to run on | `list(string)` | `[]` | no |
| <a name="input_databricks_host"></a> [databricks\_host](#input\_databricks\_host) | Databricks host name for tagging | `string` | n/a | yes |
| <a name="input_databricks_log_bucket"></a> [databricks\_log\_bucket](#input\_databricks\_log\_bucket) | Name of S3 bucket to store Databricks logs | `string` | n/a | yes |
| <a name="input_databricks_workspace_id"></a> [databricks\_workspace\_id](#input\_databricks\_workspace\_id) | Databricks workspace\_id for tagging | `string` | n/a | yes |
| <a name="input_personal_compute_pool_ids"></a> [personal\_compute\_pool\_ids](#input\_personal\_compute\_pool\_ids) | List of personal compute pool ids allowed | `list(string)` | `[]` | no |
| <a name="input_policy_name_prefix"></a> [policy\_name\_prefix](#input\_policy\_name\_prefix) | Prefix for policy names | `string` | `""` | no |

## Outputs

No outputs.
<!-- END -->
