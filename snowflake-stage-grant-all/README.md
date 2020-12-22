<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| snowflake | ~> 0.20.0 |

## Providers

| Name | Version |
|------|---------|
| snowflake | ~> 0.20.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database\_name | The name of the database containing the current stage on which to grant privileges. | `string` | `null` | no |
| on\_future | When this is set to true and a schema\_name is provided, apply this grant on all future stages in the given schema. When this is true and no schema\_name is provided apply this grant on all future stages in the given database. The stage\_name and shares fields must be unset in order to use on\_future. | `bool` | `null` | no |
| per\_privilege\_grants | A map of privileges to authorized roles and shares. Privileges must be UPPER case.<br>  This allows you to authorize extra roles/shares for specific privileges. | `map(object({shares = list(string),roles = list(string)}))` | `{}` | no |
| roles | Grants privilege to these roles. | `set(string)` | `null` | no |
| schema\_name | The name of the schema containing the current stage on which to grant privileges. | `string` | `null` | no |
| shares | Grants privilege to these shares (only valid if on\_future is false). | `set(string)` | `null` | no |
| stage\_name | The name of the stage on which to grant privilege (only valid if on\_future is false). | `string` | `null` | no |
| with\_grant\_option | When this is set to true, allows the recipient role to grant the privileges to other roles. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| privileges | Privileges that make up the ALL set. |

<!-- END -->
