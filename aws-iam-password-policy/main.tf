resource "aws_iam_account_password_policy" "strict" {
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
  minimum_password_length        = 14
  password_reuse_prevention      = 24
}
