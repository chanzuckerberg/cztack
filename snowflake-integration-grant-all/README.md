<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_snowflake"></a> [snowflake](#requirement\_snowflake) | >= 0.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_snowflake"></a> [snowflake](#provider\_snowflake) | 0.34.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [snowflake_integration_grant.all](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/integration_grant) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_multiple_grants"></a> [enable\_multiple\_grants](#input\_enable\_multiple\_grants) | When this is set to true, multiple grants of the same type can be created. This will cause Terraform to not revoke grants applied to roles and objects outside Terraform. | `bool` | `null` | no |
| <a name="input_integration_name"></a> [integration\_name](#input\_integration\_name) | Identifier for the integration; must be unique for your account. | `string` | `null` | no |
| <a name="input_per_privilege_grants"></a> [per\_privilege\_grants](#input\_per\_privilege\_grants) | A map of privileges to authorized roles and shares. Privileges must be UPPER case.<br>  This allows you to authorize extra roles/shares for specific privileges. | `map(object({roles = list(string)}))` | `{}` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Grants privilege to these roles. | `set(string)` | `null` | no |
| <a name="input_with_grant_option"></a> [with\_grant\_option](#input\_with\_grant\_option) | When this is set to true, allows the recipient role to grant the privileges to other roles. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_privileges"></a> [privileges](#output\_privileges) | Privileges that make up the ALL set. |
<!-- END -->
