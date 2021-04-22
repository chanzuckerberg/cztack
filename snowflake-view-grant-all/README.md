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
| [snowflake_view_grant.all](https://registry.terraform.io/providers/chanzuckerberg/snowflake/latest/docs/resources/view_grant) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the database containing the current or future views on which to grant privileges. | `string` | `null` | no |
| <a name="input_on_future"></a> [on\_future](#input\_on\_future) | When this is set to true and a schema\_name is provided, apply this grant on all future views in the given schema. When this is true and no schema\_name is provided apply this grant on all future views in the given database. The view\_name and shares fields must be unset in order to use on\_future. | `bool` | `null` | no |
| <a name="input_per_privilege_grants"></a> [per\_privilege\_grants](#input\_per\_privilege\_grants) | A map of privileges to authorized roles and shares. Privileges must be UPPER case.<br>  This allows you to authorize extra roles/shares for specific privileges. | `map(object({shares = list(string),roles = list(string)}))` | `{}` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Grants privilege to these roles. | `set(string)` | `null` | no |
| <a name="input_schema_name"></a> [schema\_name](#input\_schema\_name) | The name of the schema containing the current or future views on which to grant privileges. | `string` | `null` | no |
| <a name="input_shares"></a> [shares](#input\_shares) | Grants privilege to these shares (only valid if on\_future is unset). | `set(string)` | `null` | no |
| <a name="input_view_name"></a> [view\_name](#input\_view\_name) | The name of the view on which to grant privileges immediately (only valid if on\_future is unset). | `string` | `null` | no |
| <a name="input_with_grant_option"></a> [with\_grant\_option](#input\_with\_grant\_option) | When this is set to true, allows the recipient role to grant the privileges to other roles. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_privileges"></a> [privileges](#output\_privileges) | Privileges that make up the ALL set. |
<!-- END -->
