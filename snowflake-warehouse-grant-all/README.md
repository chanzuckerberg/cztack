<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_snowflake"></a> [snowflake](#requirement\_snowflake) | >= 0.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_snowflake"></a> [snowflake](#provider\_snowflake) | >= 0.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [snowflake_warehouse_grant.all](https://registry.terraform.io/providers/chanzuckerberg/snowflake/latest/docs/resources/warehouse_grant) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_per_privilege_grants"></a> [per\_privilege\_grants](#input\_per\_privilege\_grants) | A map of privileges to authorized roles and shares. Privileges must be UPPER case.<br>  This allows you to authorize extra roles/shares for specific privileges. | `map(object({roles = list(string)}))` | `{}` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Grants privilege to these roles. | `set(string)` | `null` | no |
| <a name="input_warehouse_name"></a> [warehouse\_name](#input\_warehouse\_name) | The name of the warehouse on which to grant privileges. | `string` | `null` | no |
| <a name="input_with_grant_option"></a> [with\_grant\_option](#input\_with\_grant\_option) | When this is set to true, allows the recipient role to grant the privileges to other roles. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_privileges"></a> [privileges](#output\_privileges) | Privileges that make up the ALL set. |
<!-- END -->
