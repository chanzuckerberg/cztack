# DEPRECATED

This module is deprecated and is no longer maintained. It uses the legacy `snowflake_*_grant` resources, which were removed in v1.0.0 of the [Snowflake Terraform provider](https://github.com/Snowflake-Labs/terraform-provider-snowflake), so it is pinned to provider versions `< 1.0.0`.

New code should use the provider's `snowflake_grant_privileges_to_account_role` / `snowflake_grant_privileges_to_database_role` resources directly. See the provider's [migration guide](https://github.com/Snowflake-Labs/terraform-provider-snowflake/blob/main/MIGRATION_GUIDE.md).

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_snowflake"></a> [snowflake](#requirement\_snowflake) | >= 0.20.0, < 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_snowflake"></a> [snowflake](#provider\_snowflake) | >= 0.20.0, < 1.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [snowflake_database_grant.all](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/database_grant) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the database on which to grant privileges. | `string` | `null` | no |
| <a name="input_enable_multiple_grants"></a> [enable\_multiple\_grants](#input\_enable\_multiple\_grants) | When this is set to true, multiple grants of the same type can be created. This will cause Terraform to not revoke grants applied to roles and objects outside Terraform. | `bool` | `null` | no |
| <a name="input_per_privilege_grants"></a> [per\_privilege\_grants](#input\_per\_privilege\_grants) | A map of privileges to authorized roles and shares. Privileges must be UPPER case.<br>  This allows you to authorize extra roles/shares for specific privileges. | `map(object({shares = list(string),roles = list(string)}))` | `{}` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Grants privilege to these roles. | `set(string)` | `null` | no |
| <a name="input_shares"></a> [shares](#input\_shares) | Grants privilege to these shares. | `set(string)` | `null` | no |
| <a name="input_with_grant_option"></a> [with\_grant\_option](#input\_with\_grant\_option) | When this is set to true, allows the recipient role to grant the privileges to other roles. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_privileges"></a> [privileges](#output\_privileges) | Privileges that make up the ALL set. |
<!-- END -->
