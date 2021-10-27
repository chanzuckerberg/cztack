# Redis Replication Group

This module creates a Elasticache Redis cluster using
a replication group with the given parameters.

<!-- START -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sg"></a> [sg](#module\_sg) | terraform-aws-modules/security-group/aws | 4.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_replication_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Whether changes should be applied immediately or during the next maintenance window. | `bool` | `true` | no |
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input\_at\_rest\_encryption\_enabled) | Whether to enable encryption at rest. Default: false. | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zone in which this instance should run. | `list(string)` | `null` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of Redis to run. See [supported versions](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/supported-engine-versions.html) | `string` | `"5.0.5"` | no |
| <a name="input_env"></a> [env](#input\_env) | Env for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_ingress_security_group_ids"></a> [ingress\_security\_group\_ids](#input\_ingress\_security\_group\_ids) | Source security groups which should be able to contact this instance. | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to run. See [supported node types](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html) | `string` | `"cache.m5.large"` | no |
| <a name="input_number_cache_clusters"></a> [number\_cache\_clusters](#input\_number\_cache\_clusters) | Number of cache clusters. Default 1. | `number` | `1` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner for tagging and naming. See [doc](../README.md#consistent-tagging). | `string` | n/a | yes |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Parameter group to use for this Redis cache. | `string` | `"default.redis5.0"` | no |
| <a name="input_port"></a> [port](#input\_port) | Port to host Redis on. | `number` | `6379` | no |
| <a name="input_project"></a> [project](#input\_project) | Project for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | n/a | yes |
| <a name="input_replication_group_description"></a> [replication\_group\_description](#input\_replication\_group\_description) | A user-created description for the replication group. | `string` | n/a | yes |
| <a name="input_resource_name"></a> [resource\_name](#input\_resource\_name) | If not set, name will be [var.project]-[var.env]-[var.name]. | `string` | `""` | no |
| <a name="input_service"></a> [service](#input\_service) | Service for tagging and naming. See [doc](../README.md#consistent-tagging) | `string` | `"redis"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnets to which this EC instance should be attached. They should probably be private. | `list(string)` | n/a | yes |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | Whether to enable encryption in transit. Default: false. | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC where the cache will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configuration_endpoint_address"></a> [configuration\_endpoint\_address](#output\_configuration\_endpoint\_address) | The configuration endpoint address to allow host discovery. |
| <a name="output_port"></a> [port](#output\_port) | Redis TCP port. |
| <a name="output_primary_endpoint_address"></a> [primary\_endpoint\_address](#output\_primary\_endpoint\_address) | The endpoint of the primary node in this node group (shard). |
<!-- END -->
