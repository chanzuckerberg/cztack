# DEPRECATED

This module is deprecated and is no longer maintained. It uses the legacy `snowflake_*_grant` resources, which were removed in v1.0.0 of the [Snowflake Terraform provider](https://github.com/Snowflake-Labs/terraform-provider-snowflake), so it is pinned to provider versions `< 1.0.0`.

New code should use the provider's `snowflake_grant_privileges_to_account_role` / `snowflake_grant_privileges_to_database_role` resources directly. See the provider's [migration guide](https://github.com/Snowflake-Labs/terraform-provider-snowflake/blob/main/MIGRATION_GUIDE.md).
