# Snowflake Table Grant All
Grants the ALL privilege on a table. See the [Snowflake docs](https://docs.snowflake.com/en/user-guide/security-access-control-privileges.html#table-privileges) for more information.

We do this, rather than building this to the provider, because Snowflake doesn't reflect back to you the fact that you've created an ALL grant or not. Therefore, we instead opt to individually grant each privilege.

Note that we will have to keep updating the set of ALL privileges as Snowflake modifies the set.

## Example

```hcl
module "foo_table_grant_all" {
  source = "github.com/chanzuckerberg/cztack/snowflake-table-grant-all?ref=main"

  database_name = "foo"
  schema_name = "bar"
  table_name = "baz"

  roles = ["a", "b", "c"]
}
```

<!-- START -->
## Requirements

| Name | Version |
|------|---------|
| snowflake | > 2.18.1 |

## Providers

| Name | Version |
|------|---------|
| snowflake | > 2.18.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database\_name | The name of the database that contains this table. | `string` | n/a | yes |
| on\_future | When set to true, and schema\_name present, apply grant to all future tables in schema.<br>  When set to true, and schema\_name absent, apply grant to all future tables in database.<br><br>  NOTE: table\_name and shares must be unset in order to use on\_future. | `bool` | `null` | no |
| roles | Grants privilege to these roles. | `set(string)` | `null` | no |
| schema\_name | The name of the schema that contains this table. | `string` | `null` | no |
| shares | Grants privilege to these shares (only valid if on\_future is unset). | `set(string)` | `null` | no |
| table\_name | The name of the table you want to grant permissions to. | `string` | `null` | no |
| with\_grant\_option | When this is set to true, allows the recipient role to grant the privileges to other roles. | `bool` | `null` | no |

## Outputs

No output.

<!-- END -->
