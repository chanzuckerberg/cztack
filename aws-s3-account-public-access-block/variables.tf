variable restrict {
  type        = string
  default     = "all"
  description = <<EOF
  How restrictive should the account-wide access block be. Accepted values are `all`, `new`, `none`.
  `all` blocks public access to all buckets in account.
  `new` prevents you from granting public access to any more buckets, existing public buckets remain public.
  `none` restricts no access.
  EOF

  # # TODO(el): on tf 0.13
  #  validation {
  #    condition {
  #       (var.restrict == "all" || var.restrict == "new" || var.restrict == "none")
  #    }
  #    error_message = "restrict must be one of (all, new, none)"
  #  }
}
