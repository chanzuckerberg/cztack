variable owner {
  type        = string
  description = "Owner for tagging and naming."
}

variable project {
  type        = string
  description = "Project for tagging and naming."
}

variable service {
  type        = string
  description = "Service for tagging and naming."
}

variable env {
  type        = string
  description = "Env for tagging and naming."
}

variable caller_account_id {
  type        = string
  description = "The account_id we delegate access to"
}

variable sts_external_id {
  type        = string
  description = <<EOF
  Nonsensitive identifier for delegating third party access. More about it [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html).  
  The Condition statement will look like this: `"Condition": {"StringEquals": {"sts:ExternalId": var.sts_external_id}}`
  EOF
}
