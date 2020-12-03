variable database_name {
  type        = string
  description = "The name of the database that contains this table."
}

variable schema_name {
  type        = string
  description = "The name of the schema that contains this table."

  default = null
}

variable table_name {
  type        = string
  description = "The name of the table you want to grant permissions to."

  default = null
}

variable on_future {
  type        = bool
  description = <<EOF
  When set to true, and schema_name present, apply grant to all future tables in schema.
  When set to true, and schema_name absent, apply grant to all future tables in database.

  NOTE: table_name and shares must be unset in order to use on_future.
  EOF

  default = null
}

variable roles {
  type        = set(string)
  description = "Grants privilege to these roles."

  default = null
}

variable shares {
  type        = set(string)
  description = "Grants privilege to these shares (only valid if on_future is unset)."

  default = null
}

variable with_grant_option {
  type        = bool
  description = "When this is set to true, allows the recipient role to grant the privileges to other roles."

  default = null
}
